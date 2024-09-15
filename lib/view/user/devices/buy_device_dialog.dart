import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/view/widgets/cached_network_image.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:path/path.dart';

class BuyDeviceDialog extends StatefulWidget {
  final DeviceModel deviceData;
  const BuyDeviceDialog({super.key, required this.deviceData});

  @override
  State<BuyDeviceDialog> createState() => _BuyDeviceDialogState();
}

class _BuyDeviceDialogState extends State<BuyDeviceDialog> {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  XFile? attachFile;
  String imageUrl = '';
  bool loading = false, showError = false;

  submitForm() async {
    if (attachFile == null) {
      setState(() {
        showError = true;
      });
      return;
    }

    setState(() {
      showError = false;
      loading = true;
    });

    if (attachFile != null) {
      while (!imageUrl.startsWith('http')) {
        try {
          imageUrl = await firebaseStorage
              .ref()
              .child('transfer/$id/${basename(attachFile!.path)}')
              .getDownloadURL();
        } catch (e) {
          //
        }
      }
    }

    await firestore.collection('transfer').doc(id).set({
      'userData': authController.userData!.toJson(),
      'id': id,
      'status': 'pending',
      'deviceData': widget.deviceData.toJson(),
      'attachFile': imageUrl,
      'timestamp': DateTime.now().toIso8601String()
    });

    attachFile = null;
    Get.back();
    Get.showSnackbar(GetSnackBar(
      margin: const EdgeInsets.all(20),
      message:
          'thanks_for_your_request_and_we_will_check_it_and_response_in_48_hours'
              .tr,
      duration: const Duration(seconds: 5),
      borderRadius: 20,
    ));
  }

  pickImage() async {
    final XFile? pickedImages = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImages != null) {
      setState(() {
        attachFile = pickedImages;
      });

      String filePath = 'transfer/$id/${basename(attachFile!.path)}';
      final fileBytes = attachFile!.readAsBytes();
      firebaseStorage
          .ref()
          .child(filePath)
          .putData(
              await fileBytes,
              SettableMetadata(
                contentType: 'image/jpeg',
              ))
          .then((e) async {
        imageUrl = await firebaseStorage.ref().child(filePath).getDownloadURL();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;
    return SizedBox(
      height: isMobile ? Get.height : 300,
      width: isMobile ? Get.width : 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${'please_transfer'.tr} ${widget.deviceData.subscriptionPrice.toStringAsFixed(2)} \$ ${'${'to_this_wallet_address_then_attach_the_transfer_image'.tr}:'}',
              style: const TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  authController.appData!.wallet,
                ),
                const SizedBox(width: 5),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: authController.appData!.wallet));
                      Get.showSnackbar(GetSnackBar(
                        margin: const EdgeInsets.all(20),
                        message: 'wallet_address_copied_to_clipboard'.tr,
                        duration: const Duration(seconds: 5),
                        borderRadius: 20,
                      ));
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 16,
                      color: appTheme.primaryColor,
                    ))
              ],
            ),
          ),
          attachFile == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: appTheme.primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'attach_file'.tr,
                          style: TextStyle(
                            color: appTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                      leading: CustomImageNetwork(
                          url: attachFile!.path,
                          width: 50,
                          height: 50,
                          boxFit: BoxFit.fill),
                      title: Text(
                        attachFile!.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            attachFile = null;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )),
                ),
          if (showError)
            Text(
              'please_pick_an_attach_of_your_transfer'.tr,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
                title: 'submit',
                function: () {
                  submitForm();
                },
                loading: loading,
                width: 100,
                color: appTheme.primaryColor),
          )
        ],
      ),
    );
  }
}

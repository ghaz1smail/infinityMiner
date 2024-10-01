import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/models/request_model.dart';
import 'package:infinityminer/view/admin/select_device_dialog.dart';
import 'package:infinityminer/view/widgets/cached_network_image.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_chip.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';
import 'package:infinityminer/view/widgets/full_screen.dart';
import 'package:intl/intl.dart';

class AdminRequestDetails extends StatefulWidget {
  const AdminRequestDetails({super.key});

  @override
  State<AdminRequestDetails> createState() => _AdminRequestDetailsState();
}

class _AdminRequestDetailsState extends State<AdminRequestDetails> {
  final id = Get.parameters['id'];
  bool loading = true, updating = false;
  RequestModel? requestData;

  getRequestData() async {
    await firestore.collection('transfer').doc(id).get().then((doc) {
      if (doc.exists) {
        requestData = RequestModel.fromJson(doc.data() as Map);
      }
    });
    setState(() {
      loading = false;
    });
  }

  acceptSatus(DeviceModel device) async {
    setState(() {
      loading = true;
    });
    await firestore
        .collection('transfer')
        .doc(id)
        .update({'status': 'accepted'});
    firestore.collection('history').doc(id).set({
      'id': id,
      'type': 'device',
      'timestamp': DateTime.now().toIso8601String(),
      'userData': requestData!.userData.toJson(),
      'deviceData': device.toJson(),
      'requestData': requestData!.toJson(),
    });

    firestore
        .collection('users')
        .doc(requestData!.userData.uid)
        .update({'deviceId': device.id, 'lastMining': ''});
    getRequestData();
  }

  @override
  void initState() {
    adminController.checkUserRoute();
    getRequestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const CustomLoading()
          : CustomScrollBar(
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${requestData!.id}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Chip(
                      backgroundColor: requestData!.status == 'pending'
                          ? Colors.orange
                          : requestData!.status == 'accepted'
                              ? Colors.green
                              : Colors.red,
                      label: Text(
                        '${'status'.tr}: ${requestData!.status}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      CustomChip(
                        title: '${'name'.tr}: ${requestData!.userData.name}',
                        onTap: () {
                          Get.toNamed(
                              '/user-details/${requestData!.userData.uid}');
                        },
                      ),
                      CustomChip(
                        title:
                            '${'username'.tr}: ${requestData!.userData.username}',
                      ),
                      CustomChip(
                        title: '${'email'.tr}: ${requestData!.userData.email}',
                      ),
                      CustomChip(
                        title:
                            '${'date_time'.tr}: ${DateFormat('yyyy-MM-dd | hh:mm').format(DateTime.parse(requestData!.timestamp))}',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FullScreen(image: requestData!.attachFile));
                    },
                    child: CustomImageNetwork(
                        url: requestData!.attachFile,
                        width: 200,
                        height: 200,
                        boxFit: BoxFit.fill),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${'device_data'.tr}:',
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: requestData!.deviceData
                        .toJson()
                        .entries
                        .map((m) =>
                            m.key == 'name' || m.key == 'subscriptionPrice'
                                ? CustomChip(
                                    title:
                                        '${m.key.tr}: ${m.value} ${m.key == 'subscriptionPrice' ? ' \$' : ''}',
                                  )
                                : const SizedBox())
                        .toList(),
                  ),
                  if (requestData!.status == 'pending')
                    const Divider(
                      thickness: 2,
                      color: Colors.white,
                      height: 50,
                    ),
                  if (requestData!.status == 'pending')
                    Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        CustomButton(
                          title: 'accept',
                          function: () async {
                            acceptSatus(requestData!.deviceData);
                          },
                          width: 200,
                          color: Colors.green,
                        ),
                        CustomButton(
                          title: 'select_device',
                          function: () async {
                            customUi.customDialog(SelectDeviceDialog(
                              requestData: requestData!,
                              getData: (x) async {
                                acceptSatus(x);
                              },
                            ));
                          },
                          width: 200,
                          color: Colors.blue,
                        ),
                        CustomButton(
                          title: 'reject',
                          function: () async {
                            setState(() {
                              loading = true;
                            });
                            await firestore
                                .collection('transfer')
                                .doc(id)
                                .update({'status': 'rejected'});
                            getRequestData();
                          },
                          width: 200,
                          color: Colors.red,
                        )
                      ],
                    )
                ],
              ),
            )),
    );
  }
}

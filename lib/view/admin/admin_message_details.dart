import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/message_model.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_chip.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class AdminMessageDetailsScreen extends StatefulWidget {
  const AdminMessageDetailsScreen({super.key});

  @override
  State<AdminMessageDetailsScreen> createState() =>
      _AdminMessageDetailsScreenState();
}

class _AdminMessageDetailsScreenState extends State<AdminMessageDetailsScreen> {
  final id = Get.parameters['id'];
  bool loading = true;
  MessageModel? messageData;

  getUserData({updating = false}) async {
    if (updating) {
      setState(() {
        loading = true;
      });
    }
    await firestore.collection('contact').doc(id).get().then((doc) {
      if (doc.exists) {
        messageData = MessageModel.fromJson(doc.data() as Map);
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    adminController.checkUserRoute();
    getUserData();
    super.initState();
  }

  Future<bool> sendEmail(dynamic templateParams) async {
    try {
      await emailjs.send(
        'service_9fgjbwt',
        'template_qvq4z2h',
        templateParams,
        const emailjs.Options(
          publicKey: '0CwPL1mCMK-zej4Kh',
          privateKey: '6KjB_xxiZBWbyLGkEopem',
        ),
      );
      print('SUCCESS!');
      return true;
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const CustomLoading()
          : CustomScrollBar(
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  CustomChip(
                    title: '${'name'.tr}: ${messageData!.name}',
                  ),
                  CustomChip(
                    title: '${'email'.tr}: ${messageData!.email}',
                  ),
                  CustomChip(
                    title: '${'message'.tr}: ${messageData!.message}',
                  ),
                  CustomButton(
                      title: 'send',
                      function: () {
                        sendEmail(
                          {
                            'to_email': 'gh0zism0il@gmail.com',
                            'message': 'Hi',
                          },
                        );
                      },
                      width: 200,
                      color: appTheme.primaryColor)
                ],
              ),
            )),
    );
  }
}

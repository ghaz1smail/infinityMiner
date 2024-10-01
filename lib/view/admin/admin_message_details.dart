import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/contact_model.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_chip.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class AdminMessageDetailsScreen extends StatefulWidget {
  const AdminMessageDetailsScreen({super.key});

  @override
  State<AdminMessageDetailsScreen> createState() =>
      _AdminMessageDetailsScreenState();
}

class _AdminMessageDetailsScreenState extends State<AdminMessageDetailsScreen> {
  final id = Get.parameters['id'];
  bool loading = true, sending = false;
  ContactModel? messageData;
  TextEditingController messageController = TextEditingController();

  getUserData({updating = false}) async {
    if (updating) {
      setState(() {
        loading = true;
      });
    }
    await firestore.collection('contact').doc(id).get().then((doc) {
      if (doc.exists) {
        messageData = ContactModel.fromJson(doc.data() as Map);
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
                    onTap: () {
                      Get.toNamed('/user-details/${messageData!.uid}');
                    },
                  ),
                  CustomChip(
                    title: '${'email'.tr}: ${messageData!.email}',
                  ),
                  CustomChip(
                    title: '${'message'.tr}: ${messageData!.message}',
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                            hintText: 'message', border: InputBorder.none),
                      ),
                    ),
                  ),
                  CustomButton(
                      title: 'send',
                      function: () async {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        setState(() {
                          sending = true;
                        });
                        await firestore.collection('messages').doc(id).set({
                          'id': id,
                          'message': messageController.text,
                          'contactId': messageData!.id,
                          'contactMessage': messageData!.message,
                          'status': 'pending',
                          'uid': messageData!.uid,
                          'timestamp': DateTime.now().toIso8601String()
                        });

                        messageController.clear();

                        setState(() {
                          sending = false;
                        });
                      },
                      width: 200,
                      loading: sending,
                      color: appTheme.primaryColor)
                ],
              ),
            )),
    );
  }
}

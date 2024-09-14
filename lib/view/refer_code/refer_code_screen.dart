import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class ReferCodeScreen extends StatefulWidget {
  const ReferCodeScreen({super.key});

  @override
  State<ReferCodeScreen> createState() => _ReferCodeScreenState();
}

class _ReferCodeScreenState extends State<ReferCodeScreen> {
  final userId = Get.parameters['userId'];
  bool loading = true;
  String type = '';
  UserModel? userData;

  checkUserId() async {
    await authController.getCurrentUserData();
    if (authController.userData != null) {
      if (authController.userData!.username == userId.toString()) {
        type = 'same_user';
        setState(() {
          loading = false;
        });
        return;
      }
      if (authController.userData!.codeIUse.isNotEmpty) {
        type = 'already_have_using_code';
        setState(() {
          loading = false;
        });
        return;
      }
    }
    await firestore
        .collection('users')
        .where('username', isEqualTo: userId)
        .get()
        .then((t) async {
      if (t.docs.isEmpty) {
        type = 'not_found';
      } else {
        userData = UserModel.fromJson(t.docs.first.data());
        if (userData != null) {
          if (authController.userData != null) {
            await firestore.collection('users').doc(userData!.uid).update({
              'userUsingCode':
                  FieldValue.arrayUnion([authController.userData!.uid])
            });
            await firestore
                .collection('users')
                .doc(authController.userData!.uid)
                .update({'codeIUse': userData!.uid});
            type = 'success';
          } else {
            authController.referCode = userId.toString();
            Get.offAllNamed('/');
          }
        }
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    checkUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const CustomLoading()
          : type == 'not_found'
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'sorry :('.tr,
                        style: const TextStyle(
                            fontSize: 50,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 50),
                        child: Text(
                          'user_not_found'.tr,
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomButton(
                          title: 'back',
                          function: () {
                            Get.offAllNamed('/');
                          },
                          width: 100,
                          color: appTheme.primaryColor)
                    ],
                  ),
                )
              : type == 'success'
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'success'.tr,
                            style: const TextStyle(
                                fontSize: 50,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 50),
                            child: Text(
                              userId.toString(),
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CustomButton(
                              title: 'back',
                              function: () {
                                Get.offAllNamed('/');
                              },
                              width: 100,
                              color: appTheme.primaryColor)
                        ],
                      ),
                    )
                  : type == 'same_user'
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'opps'.tr,
                                style: const TextStyle(
                                    fontSize: 50,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 50),
                                child: Text(
                                  'you_are_this_user'.tr,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CustomButton(
                                  title: 'back',
                                  function: () {
                                    Get.offAllNamed('/');
                                  },
                                  width: 100,
                                  color: appTheme.primaryColor)
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'opps'.tr,
                                style: const TextStyle(
                                    fontSize: 50,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 50),
                                child: Text(
                                  'you_already_refer_to_another_code'.tr,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CustomButton(
                                  title: 'back',
                                  function: () {
                                    Get.offAllNamed('/');
                                  },
                                  width: 100,
                                  color: appTheme.primaryColor)
                            ],
                          ),
                        ),
    );
  }
}

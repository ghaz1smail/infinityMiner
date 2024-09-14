import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/models/app_model.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';

class AuthController extends GetxController {
  var getStorage = GetStorage();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      fNameController = TextEditingController(),
      lNameController = TextEditingController();
  UserModel? userData;
  bool loading = false, signIn = true, checking = true;
  AppModel? appData;
  String? referCode;

  @override
  void onInit() {
    checkUserAvailable();
    super.onInit();
  }

  //admin@infinityminer.net

  checkUserAvailable({bool goHome = true}) async {
    checking = true;
    await getCurrentUserData();
    if (userData != null) {
      if (goHome) {
        if (userData!.type == 'admin') {
          await Get.offAllNamed('/admin');
        } else {
          await Get.offAllNamed('/home');
        }
      }
    }
    checking = false;
    update();
  }

  Future<UserModel?> getUserData(uid) async {
    await firestore.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        return UserModel.fromJson(value.data() as Map);
      } else {
        return null;
      }
    });
    return null;
  }

  changeMode() {
    signIn = !signIn;
    update();
  }

  forgetingPassAuth() async {
    if (!emailController.text.contains('@')) {
      customUi.alertDialog(
        'error_occured'.tr,
        'please_enter_a_valid_email'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }
    setLoading(true);

    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          customUi.alertDialog(
            'alreadyHave'.tr,
            'this_email_address_is_associated_with_an_existing_account'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'too-many-requests':
          customUi.alertDialog(
            'too_many_requests'.tr,
            'try_again_later'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;

        default:
          customUi.alertDialog(
            'error_occured'.tr,
            e.message.toString(),
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
      }
    }

    setLoading(false);
  }

  logOut() async {
    userData = null;
    getStorage.remove('uid');
    firebaseAuth.signOut();
    Get.offAllNamed('/');
  }

  clearData() async {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
  }

  getCurrentUserData() async {
    var uid = getStorage.read('uid');
    if (uid != null) {
      await firestore.collection('users').doc(uid).get().then((value) async {
        if (value.exists) {
          userData = UserModel.fromJson(value.data() as Map);
        } else {
          await logOut();
        }
      }).onError((e, e1) async {
        await logOut();
      });
    }
  }

  getAppData() async {
    await firestore
        .collection('appData')
        .doc('appData')
        .get()
        .then((value) async {
      appData = AppModel.fromJson(value.data() as Map);
    }).onError((e, e1) {});
  }

  navigator() async {
    await getAppData();
    await getCurrentUserData();

    if (userData == null) {
      Get.offAllNamed('/');
    } else {
      if (userData!.type == 'admin') {
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/home');
        useReferCode();
      }
    }
    clearData();
  }

  useReferCode() async {
    if (userData!.codeIUse.isEmpty && referCode != null) {
      await firestore
          .collection('users')
          .where('username', isEqualTo: referCode)
          .get()
          .then((t) async {
        if (t.docs.isNotEmpty) {
          var user = UserModel.fromJson(t.docs.first.data());

          await firestore.collection('users').doc(user.uid).update({
            'userUsingCode':
                FieldValue.arrayUnion([authController.userData!.uid])
          });
          await firestore
              .collection('users')
              .doc(authController.userData!.uid)
              .update({'codeIUse': user.uid});
        }
      });
      referCode = null;
    }
  }

  signingUpAuth() async {
    setLoading(true);
    try {
      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
        customUi.alertDialog(
          'error_occured'.tr,
          'please_enter_a_valid_email'.tr,
          {},
          {
            'title': 'ok'.tr,
            'function': () {
              Get.back();
            }
          },
        );
        return;
      }

      if (passwordController.text.length < 6) {
        customUi.alertDialog(
          'error_occured'.tr,
          'password_length_should_at_least_6_character'.tr,
          {},
          {
            'title': 'ok'.tr,
            'function': () {
              Get.back();
            }
          },
        );
        return;
      }
      if (fNameController.text.length < 3) {
        customUi.alertDialog(
          'error_occured'.tr,
          'please_enter_your_name'.tr,
          {},
          {
            'title': 'ok'.tr,
            'function': () {
              Get.back();
            }
          },
        );
        return;
      }
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);

      await createUser();
      useReferCode();
      Get.offAllNamed('/home');

      TextInput.finishAutofillContext();
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      switch (e.code) {
        case 'email-already-in-use':
          customUi.alertDialog(
            'something_went_wrong'.tr,
            'this_email_address_is_already_in_use'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'too-many-requests':
          customUi.alertDialog(
            'too_many_requests'.tr,
            'try_again_later'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;

        default:
          customUi.alertDialog(
            'error_occured'.tr,
            e.message.toString(),
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
      }
    } finally {
      setLoading(false);
    }
  }

  Future<String> checkUserName(String username) async {
    String theUsername = '';

    while (theUsername.isEmpty) {
      await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((users) {
        if (users.docs.isEmpty) {
          theUsername = username;
        } else {
          username =
              (fNameController.text.trim() + users.docs.length.toString());
        }
      });
    }
    return theUsername;
  }

  createUser() async {
    getStorage.write('uid', firebaseAuth.currentUser!.uid);
    userData = UserModel(
      username: await checkUserName(fNameController.text.trim()),
      uid: firebaseAuth.currentUser!.uid,
      timestamp: DateTime.now().toIso8601String(),
      email: emailController.text.trim(),
      firstName: fNameController.text.trim(),
      userUsingCode: [],
      type: 'user',
    )
      ..password = customFormats.encryptText(passwordController.text, "pass")
      ..tags = customFormats.generateTagsCustom(fNameController.text.trim());
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(userData!.toJson());
  }

  signingInAuth() async {
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      customUi.alertDialog(
        'error_occured'.tr,
        'please_enter_a_valid_email'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }

    if (passwordController.text.length < 6) {
      customUi.alertDialog(
        'error_occured'.tr,
        'password_length_should_at_least_6_character'.tr,
        {},
        {
          'title': 'ok'.tr,
          'function': () {
            Get.back();
          }
        },
      );
      return;
    }
    setLoading(true);
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      getStorage.write('uid', firebaseAuth.currentUser!.uid);
      await navigator();
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      switch (e.code) {
        case 'wrong-password':
          customUi.alertDialog(
            'something_went_wrong'.tr,
            'incorrect_password'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'user-not-found' || 'invalid-email':
          customUi.alertDialog(
            'your_account_not_found'.tr,
            'you_can_create_a_new_account_or_try_again'.tr,
            {
              'title': 'try_again'.tr,
              'function': () {
                Get.back();
              }
            },
            {
              'title': 'create_new_account'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        case 'too-many-requests':
          customUi.alertDialog(
            'too_many_requests'.tr,
            'try_again_later'.tr,
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
        default:
          customUi.alertDialog(
            'error_occured'.tr,
            e.message.toString(),
            {},
            {
              'title': 'ok'.tr,
              'function': () {
                Get.back();
              }
            },
          );
          break;
      }
    } finally {
      setLoading(false);
    }
  }

  setLoading(x) {
    loading = x;
    update();
  }
}

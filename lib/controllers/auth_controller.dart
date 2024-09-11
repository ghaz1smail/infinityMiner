import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/models/app_model.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/screens/updated_screen.dart';
import 'package:infinityminer/models/user_model.dart';

class AuthController extends GetxController {
  var getStorage = GetStorage();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      fNameController = TextEditingController(),
      lNameController = TextEditingController();
  UsersModel? userData;
  bool loading = false, admin = false, sent = false, signIn = true;
  AppModel appData = AppModel();

  checkUserAvailable() async {
    var uid = getStorage.read('uid');
    if (uid == null) {
      Get.offAllNamed('/login');
    } else {
      if (userData == null) {
        await getCurrentUserData();
      }
    }
  }

  Future<UsersModel?> getUserData(uid) async {
    await firestore.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        return UsersModel.fromJson(value.data() as Map);
      } else {
        return null;
      }
    });
    return null;
  }

  sendVerify() {
    firebaseAuth.currentUser!.sendEmailVerification();
  }

  changeMode() {
    signIn = !signIn;
    update();
  }

  forgetingPassAuth() async {
    if (!emailController.text.contains('@')) {
      customDialog.customDialog(
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
          customDialog.customDialog(
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
          customDialog.customDialog(
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
          customDialog.customDialog(
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
    admin = false;
    userData = null;
    getStorage.remove('uid');
    if (firebaseAuth.currentUser != null) {
      firebaseAuth.signOut();
    }
    Get.offAllNamed('/login');
  }

  clearData() async {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
  }

  getCurrentUserData() async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        userData = UsersModel.fromJson(value.data() as Map);
      } else {
        await logOut();
      }
    });
  }

  navigator() async {
    await firestore
        .collection('appData')
        .doc('appData')
        .get()
        .then((value) async {
      appData = AppModel.fromJson(value.data() as Map);
    }).onError((e, e1) {
      Get.off(() => const UpdatedScreen());
    });
    if (!appData.server) {
      Get.off(() => const UpdatedScreen());
      return;
    }

    var uid = getStorage.read('uid');

    if (uid == null) {
      Get.offAllNamed('/login');
    } else {
      admin = appData.admins!.contains(uid);

      if (admin) {
        Get.offAllNamed('/admin');
      } else {
        await getCurrentUserData();
        Get.offAllNamed('/user');
        updateUserStatus(true);
      }
    }

    clearData();
  }

  signingUpAuth() async {
    setLoading(true);
    try {
      if (!emailController.text.contains('@')) {
        customDialog.customDialog(
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
        customDialog.customDialog(
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
        customDialog.customDialog(
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
      navigator();

      TextInput.finishAutofillContext();
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      switch (e.code) {
        case 'email-already-in-use':
          customDialog.customDialog(
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
          customDialog.customDialog(
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
          customDialog.customDialog(
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

  createUser() async {
    getStorage.write('uid', firebaseAuth.currentUser!.uid);
    userData = UsersModel(
      uid: firebaseAuth.currentUser!.uid,
      timestamp: DateTime.now().toIso8601String(),
      email: emailController.text.trim(),
      firstName: fNameController.text.trim(),
      type: 'user',
    )
      ..password = customFormats.encryptText(passwordController.text, "pass")
      ..tags = customFormats.generateTagsCustom(fNameController.text.trim());
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(userData!.toJson());
  }

  updateUserStatus(bool x) {
    firestore.collection('users').doc(userData!.uid).update({'online': x});
  }

  signingInAuth() async {
    if (!emailController.text.contains('@')) {
      customDialog.customDialog(
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
      customDialog.customDialog(
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
      updateUserStatus(true);
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      switch (e.code) {
        case 'wrong-password':
          customDialog.customDialog(
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
          customDialog.customDialog(
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
          customDialog.customDialog(
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
          customDialog.customDialog(
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/controllers/user_controller.dart';
import 'package:infinityminer/app/app_theme.dart';
import 'package:infinityminer/app/app_assets.dart';
import 'package:infinityminer/app/app_data.dart';
import 'package:infinityminer/controllers/auth_controller.dart';
import 'package:infinityminer/view/widgets/custom_dialog.dart';
import 'package:infinityminer/helper/custom_formats.dart';
import 'package:infinityminer/helper/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

bool isMobile = Get.width < 475;

class GetInitial {
  initialApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthController());
    Get.put(UserController());
    await GetStorage.init();
    setPathUrlStrategy();
  }
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
AppData appData = AppData();
AppAssets assets = AppAssets();
AppTheme appTheme = AppTheme();
GetStorage getStorage = GetStorage();
CustomDialog customDialog = CustomDialog();
CustomFormats customFormats = CustomFormats();
AuthController authController = Get.find<AuthController>();
UserController userController = Get.find<UserController>();

Color colorCompute(color) {
  return Color(int.parse(color.toString())).computeLuminance() > 0.5
      ? Colors.black
      : Colors.white;
}

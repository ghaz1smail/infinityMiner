import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/helper/assets.dart';
import 'package:infinityminer/helper/constant_data.dart';
import 'package:infinityminer/controllers/auth_controller.dart';
import 'package:infinityminer/view/widgets/custom_dialog.dart';
import 'package:infinityminer/helper/custom_formats.dart';
import 'package:infinityminer/helper/firebase_options.dart';

bool isMobile = Get.width < 475;

class GetInitial {
  initialApp() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    Get.put(AuthController());
    await GetStorage.init();
  }
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
AppConstant appConstant = AppConstant();
Assets assets = Assets();
GetStorage getStorage = GetStorage();
CustomDialog customDialog = CustomDialog();
CustomFormats customFormats = CustomFormats();
AuthController authController = Get.find<AuthController>();

Color colorCompute(color) {
  return Color(int.parse(color.toString())).computeLuminance() > 0.5
      ? Colors.black
      : Colors.white;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/controllers/auth_controller.dart';
import 'package:infinityminer/helper/get_initial.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().navigator();
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            height: Get.height * 0.3,
            width: Get.width * 0.3,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                assets.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

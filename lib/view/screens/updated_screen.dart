import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/screens/splash_screen.dart';

class UpdatedScreen extends StatelessWidget {
  const UpdatedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'serverOff'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                CustomButton(
                    title: 'retry',
                    function: () {
                      Get.off(() => const SplashScreen());
                    },
                    width: 200,
                    color: appConstant.primaryColor)
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: appTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              authController.userData!.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              authController.userData!.email,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                      text:
                          'https://infinityminer.net/refer-code/${authController.userData!.username}'));
                  Get.showSnackbar(GetSnackBar(
                    margin: const EdgeInsets.all(20),
                    message: 'invite_link_copied_to_clipboard'.tr,
                    duration: const Duration(seconds: 5),
                    borderRadius: 20,
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'invite_friends',
                      style: TextStyle(
                          color: appTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.person_add, color: appTheme.primaryColor)
                  ],
                ),
              ),
            ),
            CustomButton(
                title: 'log_out',
                function: () {
                  authController.logOut();
                },
                width: 150,
                height: 30,
                size: 16,
                color: Colors.red)
          ],
        ),
      ),
    );
  }
}

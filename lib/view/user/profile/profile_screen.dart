import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/user/profile/using_code_dialog.dart';
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
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My referral code: ${authController.userData!.username}  |  ',
                    style: const TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      // Clipboard.setData(ClipboardData(
                      //     text:
                      //         'https://infinityminer.net/#/refer-code/${authController.userData!.username}'));
                      Clipboard.setData(ClipboardData(
                          text: authController.userData!.username));
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
                          'invite_friends'.tr,
                          style: TextStyle(
                              color: appTheme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.person_add,
                          color: appTheme.primaryColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (authController.userData!.codeIUse.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    customUi.customDialog(const UsingCodeDialog());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'use_friend_code'.tr,
                        style: TextStyle(
                            fontSize: 20,
                            color: appTheme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.qr_code_rounded,
                        color: appTheme.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/members');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'members'.tr,
                      style: TextStyle(
                          fontSize: 20,
                          color: appTheme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.group,
                      color: appTheme.primaryColor,
                    )
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;

    return AppBar(
      title: TextButton(
        onPressed: () {
          adminController.changeSelectedIndex('/dashboard');
        },
        child: Text(
          'app_name'.tr,
          style: TextStyle(
              color: appTheme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      actions: isMobile
          ? [
              Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
              )
            ]
          : [
              TextButton(
                onPressed: () {
                  adminController.changeSelectedIndex('/requests');
                },
                child: Text(
                  'requests'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  adminController.changeSelectedIndex('/messages');
                },
                child: Text(
                  'messages'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  authController.logOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
    );
  }
}

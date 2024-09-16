import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';

class AdminDrawerMenu extends StatelessWidget {
  const AdminDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              adminController.changeSelectedIndex('/users');
            },
            title: Text(
              'users'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              adminController.changeSelectedIndex('/requests');
            },
            title: Text(
              'requests'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              adminController.changeSelectedIndex('/messages');
            },
            title: Text(
              'messages'.tr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              authController.logOut();
            },
            title: Text(
              'log_out'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

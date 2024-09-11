import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/user/drawer_menu.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    userController.checkingUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: TextButton(
            onPressed: () {},
            child: Text(
              'app_name'.tr,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: isMobile
              ? [
                  Builder(
                    builder: (context) => IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        )),
                  )
                ]
              : [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'mining_devices'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'wallet'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'mine'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'contact_us'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        authController.logOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ))
                ],
        ),
        endDrawer: isMobile ? const DrawerMenu() : null,
        body: Obx(
          () => userController.checking.value
              ? const CustomLoading()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 400,
                        child: Image.asset(
                          assets.homeWall,
                          width: Get.width,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}

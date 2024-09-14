import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/controllers/user_controller.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/user/contact_us/contact_us_screen.dart';
import 'package:infinityminer/view/user/custom_app_bar.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/user/drawer_menu.dart';
import 'package:infinityminer/view/user/home/home_screen.dart';
import 'package:infinityminer/view/user/profile/profile_screen.dart';
import 'package:infinityminer/view/user/wallet/wallet_screen.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;

    return Scaffold(
        appBar: const CustomAppBar(),
        endDrawer: isMobile ? const DrawerMenu() : null,
        body: GetBuilder(
          initState: (state) {
            userController.checkUserRoute(updateData: false);
          },
          init: UserController(),
          builder: (controller) {
            return controller.checking
                ? const CustomLoading()
                : IndexedStack(
                    index: controller.selectedIndex.value,
                    children: const [
                      HomeScreen(),
                      MiningDevicesScreen(),
                      WalletScreen(),
                      ContactUsScreen(),
                      ProfileScreen()
                    ],
                  );
          },
        ));
  }
}

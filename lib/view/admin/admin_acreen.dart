import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/controllers/admin_controller.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/admin/admin_app_bar.dart';
import 'package:infinityminer/view/admin/admin_dashboard_screen.dart';
import 'package:infinityminer/view/admin/admin_messages_screen.dart';
import 'package:infinityminer/view/admin/admin_requests_screen.dart';
import 'package:infinityminer/view/admin/admin_drawer_menu.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;

    return Scaffold(
        appBar: const AdminAppBar(),
        endDrawer: isMobile ? const AdminDrawerMenu() : null,
        body: GetBuilder(
          initState: (state) {
            adminController.checkUserRoute(updateData: false);
          },
          init: AdminController(),
          builder: (controller) {
            return controller.checking
                ? const CustomLoading()
                : IndexedStack(
                    index: controller.selectedIndex.value,
                    children: const [
                      AdminDashboardScreen(),
                      AdminRequestsScreen(),
                      AdminMessagesScreen()
                    ],
                  );
          },
        ));
  }
}

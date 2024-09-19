import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/admin/add_fund_dialog.dart';
import 'package:infinityminer/view/admin/members_dialog.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_chip.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class AdminUserDetailsScreen extends StatefulWidget {
  const AdminUserDetailsScreen({super.key});

  @override
  State<AdminUserDetailsScreen> createState() => _AdminUserDetailsScreenState();
}

class _AdminUserDetailsScreenState extends State<AdminUserDetailsScreen> {
  final id = Get.parameters['uid'];
  bool loading = true, updating = false;
  UserModel? userData;

  getUserData({updating = false}) async {
    if (updating) {
      setState(() {
        loading = true;
      });
    }
    await firestore.collection('users').doc(id).get().then((doc) {
      if (doc.exists) {
        userData = UserModel.fromJson(doc.data() as Map);
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    adminController.checkUserRoute();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const CustomLoading()
          : CustomScrollBar(
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  CustomChip(
                    title: '${'name'.tr}: ${userData!.name}',
                  ),
                  CustomChip(
                    title: '${'username'.tr}: ${userData!.username}',
                  ),
                  CustomChip(
                    title: '${'email'.tr}: ${userData!.email}',
                  ),
                  GestureDetector(
                    onTap: () {
                      customUi.customDialog(MembersDialog(
                        userData: userData!,
                      ));
                    },
                    child: Chip(
                      backgroundColor: appTheme.primaryColor,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${'members'.tr}: ${userData!.userUsingCode!.length}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (userData!.deviceId.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 250,
                              width: 250,
                              child: buildDeviceTile(
                                  appData.miningPlans.firstWhere(
                                      (w) => w.id == userData!.deviceId),
                                  buy: false)),
                          Text(
                            'current_profit'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${userData!.profit} USDT',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  CustomButton(
                      title: 'add_fund',
                      function: () {
                        customUi.customDialog(AddFundDialog(
                          userData: userData!,
                          getUserData: () {
                            getUserData(updating: true);
                          },
                        ));
                      },
                      width: 200,
                      color: appTheme.primaryColor),
                ],
              ),
            )),
    );
  }
}

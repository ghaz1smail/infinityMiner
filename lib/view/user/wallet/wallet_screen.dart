import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/user/wallet/withdraw_dialog.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:slide_countdown/slide_countdown.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double mineRate = 0, counter = 0, profit = 0, addingValue = 0;
  Timer? timer;
  bool first = true;
  DateTime timestamp = DateTime.now();

  timerx() async {
    if (authController.userData!.deviceId.isNotEmpty) {
      if (first) {
        profit = double.tryParse(authController.userData!.profit) ?? 0;
        timestamp = DateTime.tryParse(authController.userData!.lastMining) ??
            DateTime.now();
        mineRate = appData.miningPlans
            .firstWhere((w) => w.id == authController.userData!.deviceId)
            .miningRate;
        addingValue = (((mineRate / 30) / 24) / 60) / 60;
        counter =
            (addingValue * DateTime.now().difference(timestamp).inSeconds);
        first = false;
      }

      if (DateTime.now().difference(timestamp).inHours < 24) {
        counter = counter + addingValue;
        timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          setState(() {
            counter = counter + addingValue;
          });

          if (DateTime.now().difference(timestamp).inHours > 24) {
            timer.cancel();
            profit = counter + profit;
            counter = 0;

            await firestore
                .collection('users')
                .doc(authController.userData!.uid)
                .update({'profit': profit.toString()});
          }
        });
      }
    }
  }

  @override
  void initState() {
    timerx();
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${'current_device'.tr}: ',
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          authController.userData!.deviceId.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 250,
                  width: 250,
                  child: buildDeviceTile(
                      appData.miningPlans.firstWhere(
                          (w) => w.id == authController.userData!.deviceId),
                      buy: false))
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      Text(
                        'no_device_yet'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      CustomButton(
                          title: 'buy',
                          function: () {
                            userController
                                .changeSelectedIndex('/mining-devices');
                          },
                          width: 200,
                          color: appTheme.primaryColor)
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'current_profit'.tr,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$profit USTD',
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${'daily_income_counter'.tr}: ',
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$counter USTD',
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          DateTime.now().difference(timestamp).inHours < 24
              ? Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${'your_mining_session_will_end_in'.tr} ',
                        style: const TextStyle(fontSize: 20),
                      ),
                      SlideCountdown(
                          duration:
                              timestamp.add(const Duration(days: 1)).difference(
                                    DateTime.now(),
                                  ))
                    ],
                  ),
                )
              : CustomButton(
                  title: 'start_mining',
                  function: () {
                    if (authController.userData!.deviceId.isNotEmpty) {
                      if (DateTime.now().difference(timestamp).inHours > 24 ||
                          authController.userData!.lastMining.isEmpty) {
                        setState(() {
                          timestamp = DateTime.now();
                          timerx();
                        });

                        firestore
                            .collection('users')
                            .doc(authController.userData!.uid)
                            .update(
                                {'lastMining': timestamp.toIso8601String()});
                      }
                    } else {
                      userController.changeSelectedIndex('/mining-devices');
                    }
                  },
                  width: 200,
                  color: appTheme.primaryColor),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              title: 'withdraw',
              function: () {
                if (profit >= 10) {
                  customUi.customDialog(const WithdrawDialog());
                } else {
                  Get.showSnackbar(GetSnackBar(
                    margin: const EdgeInsets.all(20),
                    message: 'minimum_withdrawl_is_10_USTD'.tr,
                    duration: const Duration(seconds: 3),
                    borderRadius: 20,
                  ));
                }
              },
              width: 200,
              color: Colors.blue)
        ],
      ),
    );
  }
}

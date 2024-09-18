import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/user/devices/mining_devices_screen.dart';
import 'package:infinityminer/view/user/wallet/withdraw_dialog.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';
import 'package:slide_countdown/slide_countdown.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double mineRate = 0, counter = 0, profit = 0, addingValue = 0;
  DateTime timestamp = DateTime.now();
  bool loading = true;
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  getProfit() async {
    firestore
        .collection('users')
        .doc(authController.userData!.uid)
        .update({'profit': FieldValue.increment(counter), 'lastMining': ''});
    setState(() {
      authController.userData!.lastMining = '';
    });
    firestore.collection('history').doc(id).set({
      'id': id,
      'type': 'profit',
      'amount': profit.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'userData': authController.userData!.toJson(),
    });
  }

  initCounter({updating = true}) async {
    if (authController.userData!.deviceId.isNotEmpty) {
      if (updating) {
        setState(() {
          loading = true;
        });
      }
      await authController.getCurrentUserData();
      profit = (double.tryParse(authController.userData!.profit) ?? 0);
      timestamp = DateTime.tryParse(authController.userData!.lastMining) ??
          DateTime.now();
      mineRate = appData.miningPlans
          .firstWhere((w) => w.id == authController.userData!.deviceId)
          .miningRate;
      addingValue = (((mineRate / 30) / 24) / 60) / 60;
      counter = (addingValue * DateTime.now().difference(timestamp).inSeconds);
      if (DateTime.now().difference(timestamp).inHours >= 24 &&
          authController.userData!.lastMining.isNotEmpty) {
        await getProfit();
        counter = 0;
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    initCounter(updating: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CustomLoading()
        : CustomScrollBar(
            child: Center(
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
                              appData.miningPlans.firstWhere((w) =>
                                  w.id == authController.userData!.deviceId),
                              buy: false))
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              Text(
                                'no_device_yet'.tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
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
                        Text(
                          'current_profit'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$profit USDT',
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
                  const SizedBox(
                    height: 20,
                  ),
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
                        Text(
                          '${'daily_income_counter'.tr}: ',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$counter USDT',
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
                  const SizedBox(
                    height: 30,
                  ),
                  DateTime.now().difference(timestamp).inHours <= 24 &&
                          authController.userData!.lastMining.isNotEmpty
                      ? Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${'your_mining_session_will_end_in'.tr} ',
                                style: const TextStyle(fontSize: 20),
                              ),
                              SlideCountdown(
                                  onChanged: (value) {
                                    setState(() {
                                      counter = counter + addingValue;
                                    });
                                  },
                                  onDone: () async {
                                    if (authController
                                        .userData!.lastMining.isNotEmpty) {
                                      await getProfit();
                                      profit = profit + counter;
                                      counter = 0;
                                    }
                                  },
                                  duration: timestamp
                                      .add(const Duration(hours: 24))
                                      .difference(
                                        DateTime.now(),
                                      ))
                            ],
                          ),
                        )
                      : CustomButton(
                          title: 'start_mining',
                          function: () async {
                            if (authController.userData!.deviceId.isNotEmpty) {
                              var time = DateTime.now().toIso8601String();
                              await firestore
                                  .collection('users')
                                  .doc(authController.userData!.uid)
                                  .update({'lastMining': time});
                              initCounter();
                            } else {
                              userController
                                  .changeSelectedIndex('/mining-devices');
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
                            message: 'minimum_withdrawl_is_10_USDT'.tr,
                            duration: const Duration(seconds: 3),
                            borderRadius: 20,
                          ));
                        }
                      },
                      width: 200,
                      color: Colors.blue),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}

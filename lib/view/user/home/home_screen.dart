import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    userController.getBitCoinPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              child: Image.asset(
                assets.homeWall,
                width: Get.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 15),
              child: Column(
                children: [
                  Container(
                    width: 200.w,
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: FittedBox(
                      child: Text(
                        'unlock_the_future_of_crypto_mining_rent_virual_mining_devices_today'
                            .tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CustomButton(
                      title: 'start',
                      function: () {
                        userController.changeSelectedIndex('/mining-devices');
                      },
                      width: 200,
                      color: appTheme.primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Obx(() => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              '${'bitcoin_price'.tr}: ${userController.bitCoinPrice.value}\$',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                          child: Row(
                            children: [
                              Text(
                                '${'active_users'.tr}: ${userController.bitCoinPrice.value}',
                                style: const TextStyle(fontSize: 30),
                              ),
                              Obx(
                                () => AnimatedFlipCounter(
                                  value: userController.userCount.value,
                                  fractionDigits: 0,
                                  suffix: "",
                                  textStyle: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: FittedBox(
            child: Text(
              'about-us'.tr,
              style: const TextStyle(
                  height: 2, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(
      child: Center(
        child: Column(
          children: [
            Wrap(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.group, color: appTheme.primaryColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'users_count'.tr,
                              style: TextStyle(
                                  fontSize: 30, color: appTheme.primaryColor),
                            ),
                          ],
                        ),
                        const AnimatedFlipCounter(
                          value: 0,
                          fractionDigits: 0,
                          suffix: "",
                          textStyle: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    adminController.changeSelectedIndex('/messages');
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mail, color: appTheme.primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'messages'.tr,
                                style: TextStyle(
                                    fontSize: 30, color: appTheme.primaryColor),
                              ),
                            ],
                          ),
                          const AnimatedFlipCounter(
                            value: 0,
                            fractionDigits: 0,
                            suffix: "",
                            textStyle: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    adminController.changeSelectedIndex('/requests');
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.request_page,
                                  color: appTheme.primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'requests'.tr,
                                style: TextStyle(
                                    fontSize: 30, color: appTheme.primaryColor),
                              ),
                            ],
                          ),
                          const AnimatedFlipCounter(
                            value: 0,
                            fractionDigits: 0,
                            suffix: "",
                            textStyle: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

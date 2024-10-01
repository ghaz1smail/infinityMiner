import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(
      child: Center(
        child: Column(
          children: [
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    adminController.changeSelectedIndex('/users');
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
                          FutureBuilder(
                            future: firestore
                                .collection('users')
                                .where('type', isNotEqualTo: 'admin')
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AnimatedFlipCounter(
                                  value: snapshot.data!.size,
                                  fractionDigits: 0,
                                  suffix: "",
                                  textStyle: const TextStyle(fontSize: 30),
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
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
                          FutureBuilder(
                            future: firestore.collection('contact').get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AnimatedFlipCounter(
                                  value: snapshot.data!.size,
                                  fractionDigits: 0,
                                  suffix: "",
                                  textStyle: const TextStyle(fontSize: 30),
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
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
                          FutureBuilder(
                            future: firestore.collection('transfer').get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AnimatedFlipCounter(
                                  value: snapshot.data!.size,
                                  fractionDigits: 0,
                                  suffix: "",
                                  textStyle: const TextStyle(fontSize: 30),
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    adminController.changeSelectedIndex('/withdraw');
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
                              Icon(Icons.attach_money,
                                  color: appTheme.primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'withdraw'.tr,
                                style: TextStyle(
                                    fontSize: 30, color: appTheme.primaryColor),
                              ),
                            ],
                          ),
                          FutureBuilder(
                            future: firestore.collection('withdraw').get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AnimatedFlipCounter(
                                  value: snapshot.data!.size,
                                  fractionDigits: 0,
                                  suffix: "",
                                  textStyle: const TextStyle(fontSize: 30),
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
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

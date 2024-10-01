import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/withdraw_model.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_chip.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class AdminWithdrawDetailsScreen extends StatefulWidget {
  const AdminWithdrawDetailsScreen({super.key});

  @override
  State<AdminWithdrawDetailsScreen> createState() =>
      _AdminWithdrawDetailsScreenState();
}

class _AdminWithdrawDetailsScreenState
    extends State<AdminWithdrawDetailsScreen> {
  final id = Get.parameters['id'];
  bool loading = true, sending = false;
  WithdrawModel? withdrawData;
  TextEditingController messageController = TextEditingController();

  getUserData({updating = false}) async {
    if (updating) {
      setState(() {
        loading = true;
      });
    }
    await firestore.collection('withdraw').doc(id).get().then((doc) {
      if (doc.exists) {
        withdrawData = WithdrawModel.fromJson(doc.data() as Map);
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    adminController.checkUserRoute(updateData: false);
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
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          '/user-details/${withdrawData!.userData.uid}');
                    },
                    child: CustomChip(
                      title: '${'name'.tr}: ${withdrawData!.userData.name}',
                    ),
                  ),
                  CustomChip(
                    title: '${'amount'.tr}: ${withdrawData!.amount}',
                  ),
                  CustomChip(
                    title: '${'wallet'.tr}: ${withdrawData!.wallet}',
                  ),
                  CustomChip(
                    title: '${'status'.tr}: ${withdrawData!.status.tr}',
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  if (withdrawData!.status != 'done')
                    CustomButton(
                        title: 'done',
                        function: () async {
                          setState(() {
                            sending = true;
                          });

                          await firestore
                              .collection('withdraw')
                              .doc(id)
                              .update({
                            'status': 'done',
                          });
                          await firestore
                              .collection('users')
                              .doc(withdrawData!.userData.uid)
                              .update({
                            'profit': FieldValue.increment(
                                -double.parse(withdrawData!.amount))
                          });
                          firestore.collection('history').doc(id).set({
                            'id': id,
                            'type': 'withdraw',
                            'timestamp': DateTime.now().toIso8601String(),
                            'userData': withdrawData!.userData.toJson(),
                            'amount': withdrawData!.amount
                          });
                          await getUserData();
                          setState(() {
                            sending = false;
                          });
                        },
                        width: 200,
                        loading: sending,
                        color: appTheme.primaryColor)
                ],
              ),
            )),
    );
  }
}

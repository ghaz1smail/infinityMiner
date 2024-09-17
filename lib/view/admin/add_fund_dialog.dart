import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_text_field.dart';

class AddFundDialog extends StatefulWidget {
  final UserModel userData;
  final Function getUserData;
  final bool codePrize;
  const AddFundDialog(
      {super.key,
      required this.userData,
      required this.getUserData,
      this.codePrize = false});

  @override
  State<AddFundDialog> createState() => _AddFundDialogState();
}

class _AddFundDialogState extends State<AddFundDialog> {
  TextEditingController amount = TextEditingController();
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 600;
    return SizedBox(
      height: 300,
      width: isMobile ? Get.width : 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: 'amount',
              borderColor: Colors.black,
              controller: amount,
              type: const TextInputType.numberWithOptions(),
            ),
          ),
          CustomButton(
              title: 'submit',
              function: () async {
                if (amount.text.isEmpty) {
                  return;
                }

                setState(() {
                  loading = true;
                });

                await firestore
                    .collection('users')
                    .doc(widget.userData.uid)
                    .update({
                  'profit':
                      FieldValue.increment(double.tryParse(amount.text) ?? 0),
                  if (widget.codePrize) 'gotCodePrize': true
                });

                widget.getUserData();

                firestore.collection('history').doc(id).set({
                  'id': id,
                  'type': 'addFund',
                  'amount': amount.text,
                  'timestamp': DateTime.now().toIso8601String(),
                  'userData': widget.userData.toJson(),
                });

                setState(() {
                  loading = false;
                });
                amount.clear();

                Get.back();
                Get.showSnackbar(GetSnackBar(
                  margin: const EdgeInsets.all(20),
                  message: 'done'.tr,
                  duration: const Duration(seconds: 3),
                  borderRadius: 20,
                ));
              },
              width: 200,
              loading: loading,
              color: appTheme.primaryColor)
        ],
      ),
    );
  }
}

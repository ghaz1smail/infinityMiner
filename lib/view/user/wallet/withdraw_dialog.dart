import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_text_field.dart';

class WithdrawDialog extends StatefulWidget {
  const WithdrawDialog({super.key});

  @override
  State<WithdrawDialog> createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  TextEditingController amount = TextEditingController(),
      address = TextEditingController();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 600;
    return SizedBox(
      height: isMobile ? Get.height : 300,
      width: isMobile ? Get.width : 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'i_would_like_to_withdraw'.tr,
            style: const TextStyle(fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: 'amount',
              borderColor: Colors.black,
              controller: amount,
              type: const TextInputType.numberWithOptions(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: address,
              hint: 'enter_your_TRC20_wallet_address',
              borderColor: Colors.black,
            ),
          ),
          CustomButton(
              title: 'submit',
              function: () async {
                if (amount.text.isEmpty || address.text.isEmpty) {
                  return;
                }

                if ((double.tryParse(amount.text) ?? 0) >
                    (double.tryParse(authController.userData!.profit) ?? 0)) {
                  customUi.showToastMessage('dont_have_enough_amount');
                }

                setState(() {
                  loading = true;
                });

                await firestore.collection('withdraw').doc(id).set({
                  'id': id,
                  'userData': authController.userData!.toJson(),
                  'amount': amount.text,
                  'wallet': address.text,
                  'status': 'pending',
                  'timestamp': DateTime.now().toIso8601String()
                });

                Get.back();
                Get.showSnackbar(GetSnackBar(
                  margin: const EdgeInsets.all(20),
                  message:
                      'thanks_for_your_request_and_we_will_check_it_and_response_in_48_hours'
                          .tr,
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

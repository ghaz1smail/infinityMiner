import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_text_field.dart';

class UsingCodeDialog extends StatefulWidget {
  const UsingCodeDialog({
    super.key,
  });

  @override
  State<UsingCodeDialog> createState() => _UsingCodeDialogState();
}

class _UsingCodeDialogState extends State<UsingCodeDialog> {
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;
    return SizedBox(
      height: isMobile ? Get.height : 300,
      width: isMobile ? Get.width : 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'use_friend_code'.tr,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: '',
              controller: code,
              onSubmit: (e) {
                Get.back();
                Get.offAllNamed('/refer-code/${code.text}');
              },
              borderColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
                title: 'submit',
                function: () {
                  Get.back();
                  Get.offAllNamed('/refer-code/${code.text}');
                },
                width: 100,
                color: appTheme.primaryColor),
          )
        ],
      ),
    );
  }
}

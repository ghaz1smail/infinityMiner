import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/controllers/auth_controller.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_text_field.dart';
import 'package:infinityminer/helper/get_initial.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutofillGroup(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(35),
                    decoration: isMobile
                        ? null
                        : BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black45),
                            borderRadius: BorderRadius.circular(10)),
                    width: isMobile ? null : 400,
                    height: isMobile ? null : 600,
                    child: Column(
                      children: [
                        Image.asset(assets.logo, height: 100, width: 100),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hint: 'email',
                          controller: controller.emailController,
                          autofill: const [AutofillHints.email],
                          onSubmit: (w) {
                            controller.forgetingPassAuth();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomButton(
                            loading: controller.loading,
                            title: 'reset_password',
                            function: () async {
                              controller.forgetingPassAuth();
                            },
                            color: appConstant.primaryColor,
                            raduis: 10,
                            size: 17,
                            width: Get.width,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.offAllNamed('/login');
                          },
                          child: Text(
                            'back'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: appConstant.primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ));
  }
}

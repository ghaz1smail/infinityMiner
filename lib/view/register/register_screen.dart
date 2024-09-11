import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/controllers/auth_controller.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_text_field.dart';
import 'package:infinityminer/helper/get_initial.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                                border: Border.all(
                                    width: 0.5, color: Colors.black45),
                                borderRadius: BorderRadius.circular(10)),
                        width: isMobile ? Get.width : 400,
                        height: isMobile ? Get.height : 600,
                        child: Column(
                          children: [
                            Image.asset(assets.logo, height: 100, width: 100),
                            const SizedBox(
                              height: 20,
                            ),
                            if (!controller.signIn)
                              CustomTextField(
                                hint: 'name',
                                controller: controller.fNameController,
                                autofill: const [AutofillHints.email],
                                onSubmit: (w) {
                                  controller.signingUpAuth();
                                },
                              ),
                            CustomTextField(
                              hint: 'email',
                              controller: controller.emailController,
                              autofill: const [AutofillHints.email],
                              onSubmit: (w) {
                                if (controller.signIn) {
                                  controller.signingInAuth();
                                } else {
                                  controller.signingUpAuth();
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextField(
                                hint: 'password',
                                secure: true,
                                controller: controller.passwordController,
                                autofill: const [AutofillHints.password],
                                onSubmit: (w) {
                                  if (controller.signIn) {
                                    controller.signingInAuth();
                                  } else {
                                    controller.signingUpAuth();
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomButton(
                                loading: controller.loading,
                                title: controller.signIn ? 'log_in' : 'sign_up',
                                function: () async {
                                  if (controller.signIn) {
                                    controller.signingInAuth();
                                  } else {
                                    controller.signingUpAuth();
                                  }
                                },
                                color: appConstant.primaryColor,
                                raduis: 10,
                                size: 17,
                                width: Get.width,
                              ),
                            ),
                            if (!controller.loading && controller.signIn)
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: TextButton(
                                    onPressed: () {
                                      Get.offAllNamed('/forgot_password');
                                    },
                                    child: Text(
                                      'forgot_password'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: appConstant.primaryColor),
                                    )),
                              ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(controller.signIn
                                    ? 'dont_have_an_account'.tr
                                    : 'already_have_an_account'.tr),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.changeMode();
                                  },
                                  child: Text(
                                    controller.signIn
                                        ? 'sign_up'.tr
                                        : 'log_in'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: appConstant.primaryColor),
                                  ),
                                )
                              ],
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

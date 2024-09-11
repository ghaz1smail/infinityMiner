import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';

class UserController extends GetxController {
  RxBool checking = true.obs;

  checkingUser() async {
    checking.value = true;
    await Future.delayed(const Duration(milliseconds: 250));
    await authController.checkUserAvailable();
    checking.value = false;
  }
}

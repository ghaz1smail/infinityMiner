import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/helper/get_initial.dart';

class AdminController extends GetxController {
  var getStorage = GetStorage();
  RxInt selectedIndex = 0.obs;
  bool checking = true;

  changeSelectedIndex(String path) {
    switch (path) {
      case '/dashboard':
        selectedIndex.value = 0;
        break;
      case '/users':
        selectedIndex.value = 1;
        break;
      case '/requests':
        selectedIndex.value = 2;
        break;
      case '/messages':
        selectedIndex.value = 3;
        break;
    }
    checkUserRoute();
  }

  checkUserRoute({bool updateData = true}) async {
    checking = true;
    if (updateData) {
      update();
    }
    var uid = getStorage.read('uid');
    Get.log(uid.toString());
    if (uid != null) {
      await authController.getCurrentUserData();

      if (authController.userData!.type == 'admin') {
        checking = false;
        update();
      } else {
        Get.offAllNamed('/home');
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100));

      Get.offAllNamed('/');
    }
  }
}

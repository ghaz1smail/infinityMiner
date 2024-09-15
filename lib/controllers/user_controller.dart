import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var getStorage = GetStorage();
  RxInt selectedIndex = 0.obs, userCount = 20000.obs;
  bool checking = true;
  RxString bitCoinPrice = ''.obs;

  @override
  void onInit() {
    changeUserCount();
    super.onInit();
  }

  changeUserCount() {
    Random random = Random();
    int min = 20000, max = 30000;
    userCount.value = (min + random.nextInt(max - min));
    Timer.periodic(const Duration(seconds: 30), (c) {
      userCount.value = (min + random.nextInt(max - min)).toInt();
    });
  }

  getBitCoinPrice() async {
    var headers = {
      'Cookie':
          '__cf_bm=npAQJ4N_UOj9xx3372xPxNYC_JD_CAeAxzCdD6PDq4I-1726347504-1.0.1.1-YBqotiw3ywnbBeGUXcq6Fo5.zevF1KtXIvYmweakL.kh6wopJSsYyHgIFamijxG1N.8S0O1Vv4IhoFxM8D5z9g'
    };
    var request = http.Request('GET',
        Uri.parse('https://api.coinbase.com/v2/exchange-rates?currency=BTC'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();

      var rates = jsonDecode(body)['data']['rates'];
      bitCoinPrice.value = rates['USD'];
      update();
    }
  }

  changeSelectedIndex(String path) {
    switch (path) {
      case '/home':
        selectedIndex.value = 0;
        break;
      case '/mining-devices':
        selectedIndex.value = 1;
        break;
      case '/wallet':
        selectedIndex.value = 2;
        break;

      case '/contact-us':
        selectedIndex.value = 3;
        break;
      case '/profile':
        selectedIndex.value = 4;
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
        Get.offAllNamed('/admin');
      } else {
        checking = false;
        update();
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100));

      Get.offAllNamed('/');
    }
  }
}

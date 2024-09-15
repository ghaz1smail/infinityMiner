import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/view/user/devices/buy_device_dialog.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';

class DeviceDialog extends StatelessWidget {
  final DeviceModel deviceData;
  const DeviceDialog({super.key, required this.deviceData});

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
            '- ${deviceData.name} -',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              deviceData.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${'mining_rate'.tr}: ${deviceData.miningRate}',
              style: TextStyle(
                color: appTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 16 : 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
                title: '\$ ${deviceData.subscriptionPrice} ' 'buy',
                function: () {
                  Get.back();
                  customUi.customDialog(BuyDeviceDialog(
                    deviceData: deviceData,
                  ));
                },
                width: 100,
                color: appTheme.primaryColor),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/view/user/devices/device_dialog.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class MiningDevicesScreen extends StatefulWidget {
  const MiningDevicesScreen({super.key});

  @override
  State<MiningDevicesScreen> createState() => _MiningDevicesScreenState();
}

class _MiningDevicesScreenState extends State<MiningDevicesScreen> {
  @override
  void initState() {
    if (authController.appData == null) {
      authController.getAppData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 475;
    return Scaffold(
        body: CustomScrollBar(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: isMobile ? 1 : 1.5,
        ),
        itemCount: appData.miningPlans.length,
        itemBuilder: (context, index) {
          final device = appData.miningPlans[index];
          return _buildDeviceTile(device);
        },
      ),
    ));
  }

  Widget _buildDeviceTile(DeviceModel device) {
    bool isMobile = Get.width < 475;
    return GestureDetector(
      onTap: () {
        customUi.customDialog(DeviceDialog(
          deviceData: device,
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                device.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 20 : 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/devices/${device.image}.png',
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: isMobile
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            device.miningRate,
                            style: TextStyle(
                              color: appTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 16 : 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '\$ ${device.subscriptionPrice}',
                            style: TextStyle(
                              color: appTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 16 : 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          device.miningRate,
                          style: TextStyle(
                            color: appTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 16 : 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '\$ ${device.subscriptionPrice}',
                          style: TextStyle(
                            color: appTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 16 : 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

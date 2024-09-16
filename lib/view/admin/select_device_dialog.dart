import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/models/request_model.dart';

class SelectDeviceDialog extends StatefulWidget {
  final RequestModel requestData;
  final Function getData;
  const SelectDeviceDialog(
      {super.key, required this.requestData, required this.getData});

  @override
  State<SelectDeviceDialog> createState() => _SelectDeviceDialogState();
}

class _SelectDeviceDialogState extends State<SelectDeviceDialog> {
  DeviceModel? selectedDevice;

  @override
  void initState() {
    selectedDevice = appData.miningPlans
        .firstWhere((w) => w.id == widget.requestData.deviceData.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 600;
    return SizedBox(
      width: isMobile ? Get.width : 600,
      height: Get.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'select_device'.tr,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () async {
                      Get.back();
                      widget.getData(selectedDevice);
                    },
                    child: Text('done'.tr))
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: appData.miningPlans.length,
            itemBuilder: (context, index) {
              DeviceModel device = appData.miningPlans[index];
              return RadioListTile(
                value: device,
                activeColor: appTheme.primaryColor,
                groupValue: selectedDevice,
                onChanged: (e) {
                  setState(() {
                    selectedDevice = e;
                  });
                },
                title: Text(device.name),
                subtitle: Text('${device.subscriptionPrice} \$'),
              );
            },
          )
        ],
      ),
    );
  }
}

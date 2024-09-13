import 'package:flutter/material.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/device_model.dart';
import 'package:infinityminer/view/widgets/cached_network_image.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class MiningDevicesScreen extends StatelessWidget {
  const MiningDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollBar(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
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
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: CustomImageNetwork(
                    url: 'assets/images/devices/${device.image}.png',
                    width: 100,
                    height: 100,
                    boxFit: BoxFit.cover,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              device.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Text(
              '\$${device.subscriptionPrice}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

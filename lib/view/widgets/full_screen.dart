import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/view/widgets/cached_network_image.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: InteractiveViewer(
              child: CustomImageNetwork(
                  url: image,
                  width: Get.width,
                  height: Get.height,
                  boxFit: BoxFit.contain))),
    );
  }
}

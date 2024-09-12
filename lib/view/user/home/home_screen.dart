import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollBar(
        child: Column(
      children: [
        Stack(
          children: [
            SizedBox(
              child: Image.asset(
                assets.homeWall,
                width: Get.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 15),
              child: Column(
                children: [
                  Container(
                    width: 150.w,
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: FittedBox(
                      child: Text(
                        'unlock_the_future_of_crypto_mining_rent_virual_mining_devices_today'
                            .tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 150.w,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: FittedBox(
                      child: Text(
                        '*Welcome to Infinity Mining – Your Gateway to Cloud Mining At Infinity Mining\nwe offer a seamless and efficient way to mine cryptocurrency\nthrough virtual cloud mining.No need to invest in expensive hardware or worry\nabout power consumption and maintenance.\nOur platform allows you to rent\npowerful mining devices remotely and start earning instantly.\nBy using cutting-edge technology and secure cloud infrastructure,we provide a risk-free\nand reliable mining experience.All you need to do is select a mining device that\nfits your needs,invest once, and watch your profits grow.Each device comes with\ndetailed specifications to help you make the best choice.With our system, you’ll\nreceive daily mining rewards,ensuring consistent returns on your investment.\nAt Infinity Mining, we value transparency and ease of use.You can track your\nearnings in real-time, withdraw profits, or reinvest them for increased gains, all from\na user-friendly dashboard.\nStart mining today with Infinity Mining and be part of the future of cryptocurrency!'
                            .tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
import 'package:infinityminer/view/widgets/custom_scroll_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: appTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              authController.userData!.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              authController.userData!.email,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
                title: 'log_out',
                function: () {
                  authController.logOut();
                },
                width: 150,
                height: 30,
                size: 16,
                color: Colors.red)
          ],
        ),
      ),
    );
  }
}

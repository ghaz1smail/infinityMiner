import 'package:flutter/material.dart';
import 'package:infinityminer/helper/get_initial.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
          onPressed: () {
            authController.logOut();
          },
          icon: const Icon(Icons.logout)),
    );
  }
}

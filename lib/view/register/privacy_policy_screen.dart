import 'package:flutter/material.dart';
import 'package:infinityminer/helper/get_initial.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          appData.termsAndConditions,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infinityminer/view/admin/admin_app_bar.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AdminAppBar(),
    );
  }
}

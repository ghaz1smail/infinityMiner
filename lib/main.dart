import 'package:flutter/material.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/helper/my_app.dart';

Future<void> main() async {
  await GetInitial().initialApp();
  runApp(const MyApp());
}

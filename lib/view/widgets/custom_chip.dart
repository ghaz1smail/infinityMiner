import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String title;
  const CustomChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(25)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}

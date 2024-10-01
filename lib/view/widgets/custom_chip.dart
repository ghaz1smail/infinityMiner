import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomChip extends StatelessWidget {
  final String title;
  const CustomChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: title));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(25)),
        child: SelectableText(
          title,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

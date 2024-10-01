import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomChip extends StatelessWidget {
  final String title;
  final Function? onTap;
  const CustomChip({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: title));
        if (onTap != null) {
          onTap!();
        }
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

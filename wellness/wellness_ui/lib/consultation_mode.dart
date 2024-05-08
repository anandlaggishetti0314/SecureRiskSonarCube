import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:wellness_ui/app_colors.dart';
class ConsultationMode extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ui.VoidCallback onPressed;

  const ConsultationMode({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = isSelected ? Colors.blue : Colors.white;
    Color textColor = isSelected ? Colors.white : Colors.black;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.lightblueBorder),
            borderRadius: BorderRadius.circular(8.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
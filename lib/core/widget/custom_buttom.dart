import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final Color borderColor;
  final double width;
  final double height;
  final TextStyle textStyle;
  final VoidCallback? onPressed;

  const CustomButtom({
    super.key,
    required this.text,
    this.onTap,
    this.onPressed,
    required this.color,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
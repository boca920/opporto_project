import 'package:flutter/material.dart';


class CustomButtom extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color color;
  final Color borderColor;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const CustomButtom({
    super.key,
    required this.text,
    required this.color,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.textStyle,
    this.onTap,
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
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

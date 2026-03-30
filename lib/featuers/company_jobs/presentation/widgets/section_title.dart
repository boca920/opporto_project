import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double height;
  final Color backgroundColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.height = 48,
    this.backgroundColor = const Color(0xFFCECECE),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
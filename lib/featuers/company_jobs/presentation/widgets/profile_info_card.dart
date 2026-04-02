import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final Widget child;
  const ProfileInfoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // إضافة Shadow خفيف جداً ليطابق شكل الكروت في التصميم
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F3F3)),
      ),
      child: child,
    );
  }
}
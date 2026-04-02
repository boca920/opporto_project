import 'package:flutter/material.dart';

class ProfileSectionItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const ProfileSectionItem({super.key, required this.title, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          if (icon != null) ...[Icon(icon, color: Colors.grey, size: 20), const SizedBox(width: 12)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0x093730A3), shape: BoxShape.circle),
            child: const Icon(Icons.edit, color: Color(0xFF3B34A4), size: 18),
          ),
        ],
      ),
    );
  }
}
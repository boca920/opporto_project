import 'package:flutter/material.dart';

class ContactItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ContactItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Icon(icon, color: const Color(0xFF5C5C5C), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF818181))),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
              ],
            ),
          ),
          // زرار التعديل الصغير
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0x0D3730A3), shape: BoxShape.circle),
            child: const Icon(Icons.edit, color: Color(0xFF3730A3), size: 16),
          ),
        ],
      ),
    );
  }
}
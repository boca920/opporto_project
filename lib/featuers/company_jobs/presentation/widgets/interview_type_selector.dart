import 'package:flutter/material.dart';

class InterviewTypeSelector extends StatelessWidget {
  final String currentType;
  final VoidCallback onTap;

  const InterviewTypeSelector({
    super.key,
    required this.currentType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Interview Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(currentType, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
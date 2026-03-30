import 'package:flutter/material.dart';

class CVSection extends StatelessWidget {
  final String fileName;
  final String iconPath;
  final String editIconPath;
  final VoidCallback? onEdit;

  const CVSection({
    super.key,
    required this.fileName,
    this.iconPath = "assets/images/2.png",
    this.editIconPath = "assets/images/edit.png",
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CV", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _circleIcon(iconPath),
                  const SizedBox(width: 12),
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: onEdit,
                  child: _circleIcon(editIconPath, bg: true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(String asset, {bool bg = false}) {
    return Container(
      width: 41,
      height: 41,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg ? const Color.fromARGB(10, 0, 0, 0) : null,
        border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
      ),
      child: Image.asset(asset),
    );
  }
}
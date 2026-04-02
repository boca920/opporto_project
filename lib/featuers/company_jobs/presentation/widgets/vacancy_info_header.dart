import 'package:flutter/material.dart';

class VacancyInfoHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logoPath;
  final bool showEditIcon; // عشان لو مش عايز تظهر أيقونة التعديل في كل الصفحات
  final VoidCallback? onEditTap;

  const VacancyInfoHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    this.showEditIcon = true, // افتراضياً موجودة
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
              child: Image.asset(logoPath),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF434356)),
                ),
              ],
            ),
          ],
        ),
        // نتحكم في ظهور أيقونة التعديل
        if (showEditIcon)
          GestureDetector(
            onTap: onEditTap,
            child: Image.asset("assets/images/edit.png", width: 20),
          ),
      ],
    );
  }
}
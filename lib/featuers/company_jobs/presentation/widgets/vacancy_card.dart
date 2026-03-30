import 'package:flutter/material.dart';

class VacancyCard extends StatelessWidget {
  final String jobTitle;
  final String jobType;
  final String logoPath;

  const VacancyCard({
    super.key,
    required this.jobTitle,
    required this.jobType,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: 45, height: 45,
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
            Text(jobTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(jobType, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
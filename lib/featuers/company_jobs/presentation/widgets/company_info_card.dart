import 'package:flutter/material.dart';

class CompanyInfoCard extends StatelessWidget {
  final String logo;
  final String name;

  const CompanyInfoCard({super.key, required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50, height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
          ),
          child: Image.asset(logo, fit: BoxFit.contain),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Company name", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class ApplicationCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final Widget trailing; // هنا بنمرر السهم أو الحالة (Passed/Failed)
  final VoidCallback? onTap;

  const ApplicationCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: trailing, // الـ Widget اللي هيتبعت من بره
      ),
    );
  }
}
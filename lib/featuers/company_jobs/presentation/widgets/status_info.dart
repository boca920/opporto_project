// profile_info.dart
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String title;
  final TextAlign alignment;

  const ProfileInfo({
    super.key,
    required this.name,
    required this.title,
    this.alignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: _crossAxisAlignment(alignment),
          children: [
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  CrossAxisAlignment _crossAxisAlignment(TextAlign align) {
    switch (align) {
      case TextAlign.center: return CrossAxisAlignment.center;
      case TextAlign.end: return CrossAxisAlignment.end;
      default: return CrossAxisAlignment.start;
    }
  }
}

// status_info.dart
class StatusInfo extends StatelessWidget {
  final String label;
  final String value;

  const StatusInfo({
    super.key,
    this.label = "Status",
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
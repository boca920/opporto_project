import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_gradient_button.dart';

class ApplicationStatus {
  final String label;
  final List<Color> gradientColors;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onTap;

  ApplicationStatus({
    required this.label,
    required this.gradientColors,
    required this.textColor,
    required this.borderColor,
    this.onTap,
  });
}

class ActionButtons extends StatelessWidget {
  final List<ApplicationStatus> statuses;

  const ActionButtons({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: statuses.map((status) => Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GradientButton(
            text: status.label,
            colors: status.gradientColors,
            onTap: status.onTap ?? () {},

          ),
        )).toList(),
      ),
    );
  }
}


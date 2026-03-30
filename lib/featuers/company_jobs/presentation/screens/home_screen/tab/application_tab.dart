import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/calendar_screen/calendar_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_outlined_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_submit_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/status_badge.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_info_header.dart';

class ApplicationsTab extends StatelessWidget {
  const ApplicationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Application", isBack: false,),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VacancyInfoHeader(
                  title: 'Junior Front-End Developer',
                  subtitle: 'Full time . Remotely',
                  logoPath: 'assets/images/logo1.png',
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Application Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF15123D),
                      ),
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(
                        color: Color(0xFFFF9800),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildApplicationsList(),
                const SizedBox(height: 32),
                CustomOutlinedButton(
                  title: "Continue through mail", onTap: () {  },
                ),
                const SizedBox(height: 12),
                CustomSubmitButton(
                  title: "Submit",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalendarScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationsList() {
    return Column(
      children: const [
        ApplicationCard(
          name: "Mark Kamel",
          subtitle: "Junior Front-End Developer . Under-graduate",
          trailing: StatusBadge(status: "Passed"),
        ),
        ApplicationCard(
          name: "Ahmed Bassil",
          subtitle: "Junior Front-End Developer . Graduate",
          trailing: StatusBadge(status: "On-hold"),
        ),
        ApplicationCard(
          name: "Omar Ahmed",
          subtitle: "Junior Front-End Developer . Graduate",
          trailing: StatusBadge(status: "Failed"),
        ),
        ApplicationCard(
          name: "Mina Hany",
          subtitle: "Junior Front-End Developer . Graduate",
          trailing: StatusBadge(status: "Failed"),
        ),
      ],
    );
  }
}
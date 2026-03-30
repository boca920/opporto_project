import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/action_buttons_status.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/cv_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/info_row.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/section_title.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/skills_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/status_info.dart';


class ApplicantDetailsScreen extends StatefulWidget {
  const ApplicantDetailsScreen({super.key});

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  final applicantData = {
    'name': 'Mark Kamel',
    'email': 'markkamel@gmail.com',
    'phone': '+30 1558604028',
    'address': 'Maadi, Cairo, Egypt',
    'coverLetter': 'Iam frontend developer react.js css Html js',
    'status': 'Under-graduate',
    'cvFile': 'Mark Kamel.pdf',
    'jobTitle': 'Junior Front-End Developer',
    'skills': ['Web design', 'Technology', 'Marketing', 'Programming', 'Web design'],
  };

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: [

              CustomHeader(title: "Applicant Details",
                isBack: true,
                onBack: (){
                Navigator.pop(context);
              },),
              const SizedBox(height: 20),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SectionTitle(title: "Application from job seekers"),

                const SizedBox(height: 24),
                InfoRow(label: "Name", value:" ${applicantData['name']}"),
                InfoRow(label: "Email", value:" ${applicantData['email']}" ),
                InfoRow(label: "Phone", value: "${applicantData['phone']}"),
                InfoRow(label: "Address", value: "${applicantData['address']}"),
                InfoRow(
                  label: "Cover letter",
                  value:"${applicantData['coverLetter']}",
                  maxLines: 3,
                ),
                InfoRow(label: "Status", value:"${applicantData['status']}" ),

                const SizedBox(height: 24),
                CVSection(
                  fileName:"${applicantData['cvFile']}",
                  onEdit: () {
                    // Handle edit CV
                  },
                ),

                const SizedBox(height: 26),
                ProfileInfo(
                  name:" ${applicantData['name']}",
                  title:" ${applicantData['jobTitle']}",
                ),

                const SizedBox(height: 26),
                StatusInfo(value: "${applicantData['status']}"),

                const SizedBox(height: 26),
                SkillsSection(skills: applicantData['skills'] as List<String>),

                const SizedBox(height: 30),
                ActionButtons(
                  statuses: [
                    ApplicationStatus(
                      label: "passed",
                      gradientColors: [const Color(0xFF34AE34), const Color(
                          0xFF1A6533)],
                      textColor: Colors.green,
                      borderColor: Colors.green,
                      onTap: () => _handleStatus('passed'),
                    ),
                    ApplicationStatus(
                      label: "failed",
                      gradientColors: [const Color(0xFFFF5555), const Color(0xFF993333)],
                      textColor: Colors.white,
                      borderColor: Colors.red,
                      onTap: () => _handleStatus('failed'),
                    ),
                    ApplicationStatus(
                      label: "on hold",
                      gradientColors: [const Color(0xFFF4A014), const Color(
                          0xFFBF7E05)],
                      textColor: const Color(0xFFF69800),
                      borderColor: Colors.white,
                      onTap: () => _handleStatus('hold'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        )
            ]
        )
        );
  }

  void _handleStatus(String newStatus) {
    setState(() {
      applicantData['status'] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Updated to: $newStatus"),
        backgroundColor: newStatus == 'passed'
            ? Colors.green
            : newStatus == 'failed'
            ? Colors.red
            : Colors.orange,
      ),
    );
  }
}

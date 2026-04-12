import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/action_buttons_status.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/cv_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/info_row.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/section_title.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/skills_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/status_info.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  final ApplicationModel application;

  const ApplicantDetailsScreen({super.key, required this.application});

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.application.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: [
              CustomHeader(
                title: "Applicant Details",
                isBack: true,
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SectionTitle(title: "Application from job seekers"),
                      const SizedBox(height: 24),
                      InfoRow(label: "Name", value: widget.application.name),
                      InfoRow(label: "Email", value: widget.application.email),
                      InfoRow(label: "Phone", value: widget.application.phone),
                      InfoRow(label: "Address", value: widget.application.address),
                      InfoRow(
                        label: "Cover letter",
                        value: widget.application.coverLetter,
                        maxLines: 5,
                      ),
                      InfoRow(label: "Status", value: currentStatus),
                      const SizedBox(height: 24),
                      CVSection(
                        fileName: "${widget.application.name}_CV.pdf",
                        onEdit: () {},
                      ),
                      const SizedBox(height: 26),
                      ProfileInfo(
                        name: widget.application.name,
                        title: "Job Seeker",
                      ),
                      const SizedBox(height: 26),
                      StatusInfo(value: currentStatus),
                      const SizedBox(height: 26),
                      const SkillsSection(skills: ["Programming", "Web Design"]),
                      const SizedBox(height: 30),
                      ActionButtons(
                        statuses: [
                          ApplicationStatus(
                            label: "passed",
                            gradientColors: [const Color(0xFFA9F3A9), const Color(0xFF79AA85)],
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
                            gradientColors: [const Color(0xFFF4A014), const Color(0xFFBF7E05)],
                            textColor: const Color(0xFFF69800),
                            borderColor: Colors.white,
                            onTap: () => _handleStatus('on hold'),
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
      currentStatus = newStatus;
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
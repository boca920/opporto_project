import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_gradient_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_detail_row.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_tag.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';

class PostJobScreen extends StatefulWidget {
  final JobModel job;

  const PostJobScreen({super.key, required this.job});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  String get salaryInfo {
    if (widget.job.fixedSalary != null) return "${widget.job.fixedSalary} EGP";
    if (widget.job.minSalary != null && widget.job.maxSalary != null) {
      return "${widget.job.minSalary}-${widget.job.maxSalary} EGP";
    }
    return "Negotiable";
  }

  String get currentDate {
    final now = DateTime.now();
    return "${now.year}/${now.month}/${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomHeader(
            title: "Job Details",
            isBack: true,
            onBack: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: VacancyCard(
                      jobTitle: widget.job.jobTitle,
                      jobType: "${widget.job.jobType} : ${widget.job.workplaceType}",
                      logoPath: "assets/images/google.png",
                    ),
                  ),
                  const SizedBox(height: 16),
                  JobTag(text: widget.job.jobType),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Details",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1D177A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  JobDetailRow(title: "Title", value: widget.job.jobTitle),
                  JobDetailRow(title: "Country", value: widget.job.country),
                  JobDetailRow(title: "City", value: widget.job.city),
                  JobDetailRow(title: "Location", value: widget.job.specificLocation),
                  JobDetailRow(title: "Category", value: widget.job.category),
                  JobDetailRow(title: "Experience", value: widget.job.experienceLevel),
                  JobDetailRow(title: "Salary", value: salaryInfo),
                  JobDetailRow(title: "Posted On", value: currentDate),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: const Color(0xFF1D177A),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.job.jobDescription),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientButton(
                          text: 'edit',
                          colors: const [Color(0xFFF06400), Color(0xFF8A3A00)],
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        GradientButton(
                          text: 'delete',
                          colors: const [Color(0xFFFF5555), Color(0xFF993333)],
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
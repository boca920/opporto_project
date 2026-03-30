import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_gradient_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_detail_row.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_tag.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';

class PostJobScreen extends StatefulWidget {
  final String jobTitle;
  final String country;
  final String city;
  final String description;
  final String location;
  final String salary;
  final String category;
  final String tag;
  final String placeVal;
  final String image;



  const PostJobScreen({
    super.key,
    required this.jobTitle,
    required this.salary,
    required this.category,
    required this.country,
    required this.placeVal,
    required this.tag,
    required this.image,
    required this.city,
    required this.description,
    required this.location,
  });

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  String get currentDate {
    final now = DateTime.now();
    return "${now.year}/${now.month}/${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          CustomHeader(title: "Job Details",
            isBack: true,
            onBack: (){
              Navigator.pop(context);
            },),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: VacancyCard(
                      jobTitle: widget.jobTitle,
                      jobType:"${widget.tag}:${widget.placeVal}",
                      logoPath: widget.image,
                    ),
                  ),
                  const SizedBox(height: 16),

                  JobTag(text:  widget.tag,),
                  const SizedBox(height: 20),

                  // ===== Details =====
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
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

                  JobDetailRow(title: "Title", value: widget.jobTitle),
                  JobDetailRow(title: "Country", value: widget.country),
                  JobDetailRow(title: "City", value: widget.city),
                  JobDetailRow(title: "Location", value: widget.location),
                  JobDetailRow(
                      title: "Category", value: widget.category),
                  JobDetailRow(title: "Salary", value: widget.salary),
                  JobDetailRow(title: "Posted On", value: currentDate),

                  const SizedBox(height: 20),

                  // ===== Description =====
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
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
                    child: Text(widget.description),
                  ),

                  const SizedBox(height: 30),


                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientButton(text: 'edit', colors: [
                          Color(0xFFF06400),
                          Color(0xFF8A3A00),
                        ], onTap: () {  },),
                        const SizedBox(width: 12),
                        GradientButton(text: 'delete', colors: [
                          Color(0xFFFF5555),
                          Color(0xFF993333),
                      ],
                          onTap: () {  },),
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
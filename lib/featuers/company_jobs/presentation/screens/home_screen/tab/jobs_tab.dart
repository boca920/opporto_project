import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/post_job_screen/post_job_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_form_widgets.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_post_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/small_dropdown..dart';
class JobsTab extends StatefulWidget {
  const JobsTab({super.key});

  @override
  State<JobsTab> createState() => _JobsTabState();
}

class _JobsTabState extends State<JobsTab> {
  final titleController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  String? timeVal, levelVal, placeVal, categoryVal, salaryVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Post New Job", isBack: false,),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobPostHeader(
                  title: "Junior Front End",
                  location: "New Cairo, Egypt",
                  onImageTap: () {},
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallDropdown(hint: "Fulltime", value: timeVal, items: const ['Fulltime', 'Part-time'], onChanged: (v) => setState(() => timeVal = v)),
                    SmallDropdown(hint: "Junior", value: levelVal, items: const ['Junior', 'Senior'], onChanged: (v) => setState(() => levelVal = v)),
                    SmallDropdown(hint: "Onsite", value: placeVal, items: const ['Onsite', 'Remote'], onChanged: (v) => setState(() => placeVal = v)),
                  ],
                ),
                const SizedBox(height: 25),
                JobFormWidgets.buildLabelField(
                  label: "Job title",
                  child: JobFormWidgets.buildTextField(
                    controller: titleController,
                    hint: "junior front end developer",
                  ),
                ),
                const SizedBox(height: 20),
                JobFormWidgets.buildLabelField(
                  label: "Select category",
                  child: JobFormWidgets.buildSimpleDropdown(
                    value: categoryVal,
                    hint: "choose category...",
                    items: ['Frontend', 'Backend', 'UI/UX', 'Mobile'],
                    onChanged: (v) => setState(() => categoryVal = v),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: JobFormWidgets.buildLabelField(
                        label: "Country",
                        child: JobFormWidgets.buildTextField(controller: countryController, hint: "country"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: JobFormWidgets.buildLabelField(
                        label: "City",
                        child: JobFormWidgets.buildTextField(controller: cityController, hint: "city"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                JobFormWidgets.buildLabelField(
                  label: "Specific location",
                  child: JobFormWidgets.buildTextField(
                    controller: locationController,
                    hint: "e.g. 123 business st,tech hub",
                  ),
                ),
                const SizedBox(height: 20),
                JobFormWidgets.buildLabelField(
                  label: "Salary type",
                  child: JobFormWidgets.buildSimpleDropdown(
                    value: salaryVal,
                    hint: "select salary type",
                    items: ['2000 - 5000 EGP', '5000 - 10000 EGP', 'Negotiable'],
                    onChanged: (v) => setState(() => salaryVal = v),
                  ),
                ),
                const SizedBox(height: 20),
                JobFormWidgets.buildLabelField(
                  label: "Job Description",
                  child: JobFormWidgets.buildTextField(
                    controller: descriptionController,
                    hint: "tell us about the role, responsibilites , and requirements.....",
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostJobScreen(
                            jobTitle: titleController.text,
                            country: countryController.text,
                            tag: timeVal??"" ,
                            placeVal:placeVal??"",
                            city: cityController.text,
                            description: descriptionController.text,
                            location: locationController.text,
                            salary: salaryVal ?? "",
                            category: categoryVal ?? "",
                            image: 'assets/images/logo1.png',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3730A3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Post New Job",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
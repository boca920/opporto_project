import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/post_job_screen/post_job_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_form_widgets.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/job_post_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/small_dropdown..dart';
import 'package:provider/provider.dart';
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
                     items: ['5000', '10000', '15000'],
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
                BlocConsumer<JobBloc, JobState>(
                  listener: (context, state) {
                    if (state.status == RequestStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Job Posted Successfully!"), backgroundColor: Colors.green),
                      );
                      // يمكنك هنا تصفير الحقول أو الانتقال لشاشة أخرى
                    } else if (state.status == RequestStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message ?? "Error occurred"), backgroundColor: Colors.red),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.status == RequestStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton(
                          onPressed: () {
                            final userProvider = Provider.of<UserProvider>(context, listen: false);
                            final String? token = userProvider.token;

                            // 🔥 VALIDATION
                            if (titleController.text.isEmpty ||
                                categoryVal == null ||
                                countryController.text.isEmpty ||
                                cityController.text.isEmpty ||
                                locationController.text.isEmpty ||
                                salaryVal == null ||
                                descriptionController.text.isEmpty) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please fill all required fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            if (token != null && token.isNotEmpty) {
                              final job = JobModel(
                                jobTitle: titleController.text,
                                category: categoryVal!,
                                country: countryController.text,
                                city: cityController.text,
                                specificLocation: locationController.text,
                                fixedSalary: int.tryParse(salaryVal!),
                                jobDescription: descriptionController.text,
                                workplaceType: placeVal ?? "Onsite",
                                jobType: timeVal ?? "Fulltime",
                                experienceLevel: levelVal ?? "Junior",
                              );

                              context.read<JobBloc>().add(
                                AddJobEvent(
                                  jobData: job,
                                  userToken: token,
                                ),
                              );

                              print(job.toJson());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please login first")),
                              );
                            }
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3730A3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "post new Job",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
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
}
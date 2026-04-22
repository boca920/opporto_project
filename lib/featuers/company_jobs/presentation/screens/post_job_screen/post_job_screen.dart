import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/all_jobs/all_jobs_screen.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
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
  String _getSalaryInfo(JobModel job) {
    if (job.fixedSalary != null) return "${job.fixedSalary} EGP";
    if (job.minSalary != null && job.maxSalary != null) {
      return "${job.minSalary}-${job.maxSalary} EGP";
    }
    return "Negotiable";
  }

  String get _currentDate {
    final now = DateTime.now();
    return "${now.year}/${now.month}/${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        final currentJob = state.jobs.firstWhere(
              (element) => element.id == widget.job.id,
          orElse: () => widget.job,
        );

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
                          jobTitle: currentJob.jobTitle ?? '',
                          jobType: "${currentJob.jobType} : ${currentJob.workplaceType}",
                          logoPath: "assets/images/google.png",
                        ),
                      ),
                      const SizedBox(height: 16),
                      JobTag(text: currentJob.jobType),
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
                      JobDetailRow(title: "Title", value: currentJob.jobTitle ?? ''),
                      JobDetailRow(title: "Country", value: currentJob.country ?? ''),
                      JobDetailRow(title: "City", value: currentJob.city ?? ''),
                      JobDetailRow(title: "Location", value: currentJob.specificLocation ?? ''),
                      JobDetailRow(title: "Category", value: currentJob.category ?? ''),
                      JobDetailRow(title: "Experience", value: currentJob.experienceLevel ?? ''),
                      JobDetailRow(title: "Salary", value: _getSalaryInfo(currentJob)),
                      JobDetailRow(title: "Posted On", value: _currentDate),
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
                          child: Text(currentJob.jobDescription ?? ''),
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
                              onTap: () => _showEditJobSheet(context, currentJob),
                            ),
                            const SizedBox(width: 12),
                            GradientButton(
                              text: 'delete',
                              colors: const [Color(0xFFFF5555), Color(0xFF993333)],
                              onTap: () => _showDeleteDialog(context, currentJob.id),
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
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String? jobId) {
    if (jobId == null) return;
    final jobBloc = context.read<JobBloc>();
    final token = context.read<UserProvider>().token ?? "";

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Job"),
        content: const Text("Are you sure you want to delete this job?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              jobBloc.add(DeleteJobEvent(id: jobId, token: token));
              Navigator.pop(dialogContext);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: jobBloc,
                    child: const AllJobsScreen(),
                  ),
                ),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditJobSheet(BuildContext context, JobModel job) {
    final jobBloc = context.read<JobBloc>();
    final titleController = TextEditingController(text: job.jobTitle);
    final descController = TextEditingController(text: job.jobDescription);
    final salaryController = TextEditingController(text: job.fixedSalary?.toString());
    final countryController = TextEditingController(text: job.country);
    final cityController = TextEditingController(text: job.city);
    final locationController = TextEditingController(text: job.specificLocation);
    final categoryController = TextEditingController(text: job.category);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: jobBloc,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Edit Job", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _field("Job Title", titleController),
                  _field("Description", descController),
                  _field("Salary", salaryController, type: TextInputType.number),
                  _field("Country", countryController),
                  _field("City", cityController),
                  _field("Location", locationController),
                  _field("Category", categoryController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D177A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        final token = context.read<UserProvider>().token;
                        if (job.id == null || token == null) return;

                        jobBloc.add(UpdateJobEvent(
                          id: job.id!,
                          token: token,
                          data: {
                            "jobTitle": titleController.text,
                            "jobDescription": descController.text,
                            "fixedSalary": int.tryParse(salaryController.text),
                            "country": countryController.text,
                            "city": cityController.text,
                            "specificLocation": locationController.text,
                            "category": categoryController.text,
                          },
                        ));
                        Navigator.pop(context);
                      },
                      child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _field(String label, TextEditingController controller, {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
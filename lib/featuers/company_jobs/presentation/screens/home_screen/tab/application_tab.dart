import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/applicant_details_screen/applicant_details_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/calendar_screen/calendar_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_outlined_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_submit_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/status_badge.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_info_header.dart';

class ApplicationsTab extends StatelessWidget {
  const ApplicationsTab({super.key});

  String getApplicantName(String? applicationId, Map applicantMap) {

    final applicant = applicantMap[applicationId];

    return applicant?.name ?? "Applicant";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.indigo),
          );
        }

        if (state.status == RequestStatus.error) {
          return Center(
            child: Text(state.message ?? "Error loading data"),
          );
        }

        // ✅ 1. Applicants list
        final applicants = state.applications
            .where((a) => (a.status ?? "").toLowerCase() == "accepted")
            .toList();

        // ✅ 2. IMPORTANT: build map for fast lookup
        final Map<String, dynamic> applicantMap = {
          for (var a in applicants) a.id: a
        };
        for (var a in applicants) {
          print("Applicant ID: ${a.id}");
          print("Applicant Name: ${a.name}");
          print("Applicant Status: ${a.status}");
          print("======================================");
          print("Applicant Map: $applicantMap");
          print("======================================");
          print("Applicant Map Length: ${applicantMap.length}");
          print("======================================");
        }
        // Interviews
        final interviewModels = state.interviews;

        final validInterviews = interviewModels.where((item) {
          final hasApp = item.application != null;
          final hasDate = item.scheduledAt != null;
          final notCancelled =
              (item.status ?? "").toLowerCase() != "cancelled";

          return hasApp && hasDate && notCancelled;
        }).toList();

        return Column(
          children: [
            const CustomHeader(title: "Application", isBack: false),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VacancyInfoHeader(
                      title: 'Junior Front-End Developer',
                      subtitle: 'Full time • Remotely',
                      logoPath: 'assets/images/logo1.png',
                    ),

                    const SizedBox(height: 30),

                    _buildSectionHeader("Application Status", "Delete"),
                    const SizedBox(height: 16),

                    if (applicants.isEmpty)
                      const Center(child: Text("No applications yet"))
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: applicants.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final application = applicants[index];

                          return ApplicationCard(
                            name: application.name ?? "Applicant",
                            subtitle:
                            application.job.jobTitle ?? "No Title",
                            trailing: StatusBadge(
                              status: application.status ?? "Unknown",
                              color: Colors.green,
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ApplicantDetailsScreen(
                                  application: application,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    const SizedBox(height: 30),

                    _buildSectionHeader("Scheduled Interviews", ""),
                    const SizedBox(height: 16),

                    if (validInterviews.isEmpty)
                      const Center(child: Text("No interviews yet"))
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: validInterviews.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return _buildInterviewSessionCard(
                            validInterviews[index],
                            applicantMap,
                          );
                        },
                      ),

                    const SizedBox(height: 32),

                    CustomOutlinedButton(
                      title: "Continue through mail",
                      onTap: () {},
                    ),

                    const SizedBox(height: 12),

                    CustomSubmitButton(
                      title: "Ask for Interview",
                      onTap: () {
                        if (applicants.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CalendarScreen(
                                application: applicants.first,
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInterviewSessionCard(
      InterviewData data,
      Map applicantMap,
      ) {
    String formattedDate = "Pending Date";

    try {
      if (data.scheduledAt != null) {
        formattedDate = DateFormat('EEEE, MMM d • hh:mm a')
            .format(data.scheduledAt!.toLocal());
      }
    } catch (_) {
      formattedDate = "Invalid Date";
    }

    final isCancelled =
        (data.status ?? "").toLowerCase() == "cancelled";

    final applicantName =
    getApplicantName(data.application?.id, applicantMap);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E7FF)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.videocam_outlined,
            color: Color(0xFF4F46E5),
            size: 28,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.interviewType ?? "Unknown",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style:
                  const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isCancelled
                  ? Colors.red.withOpacity(0.1)
                  : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data.status ?? "Scheduled",
              style: TextStyle(
                color: isCancelled ? Colors.red : Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF15123D),
          ),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: const TextStyle(
              color: Color(0xFFFF9800),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/all_jobs/all_jobs_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/applicant_details_screen/applicant_details_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return const Center(child: CircularProgressIndicator(color: Colors.indigo));
        }

        if (state.status == RequestStatus.error) {
          return Center(child: Text(state.message ?? "Error loading data"));
        }

        if (state.jobs.isEmpty) {
          return const Center(child: Text("No Jobs Found"));
        }

        final latestJob = state.jobs.first;
        final applicants = state.applications;

        return Column(
          children: [
            const CustomHeader(title: "Welcome to Opporto", isBack: false),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Latest Vacancy", style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<JobBloc>(),
                                  child: const AllJobsScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text("View All", style: TextStyle(color: Colors.indigo)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    VacancyCard(
                      jobTitle: latestJob.jobTitle,
                      jobType: "${latestJob.jobType} . ${latestJob.workplaceType}",
                      logoPath: "assets/images/logo1.png",
                    ),
                    const SizedBox(height: 20),
                    const Text("Recent Applications", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    applicants.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(child: Text("No applications yet")),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: applicants.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final application = state.applications[index];

                        return ApplicationCard(
                          name: application.name,
                          subtitle: application.job?.jobTitle ?? "No Job Title" ,
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.indigo),

                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ApplicantDetailsScreen(
                                  application: application,

                                ),
                              ),
                            );
                          },

                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/post_job_screen/post_job_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/core/provider/user_provider.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          CustomHeader(
            title: "My Vacancies",
            isBack: true,
              onBack: () {
                Navigator.pop(context);
              }
          ),
          Expanded(
            child: BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if (state.status == RequestStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.indigo),
                  );
                }

                if (state.status == RequestStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 60, color: Colors.red),
                        const SizedBox(height: 10),
                        Text(state.message ?? "Error loading jobs"),
                        TextButton(
                          onPressed: () => _refreshJobs(context),
                          child: const Text("Retry"),
                        )
                      ],
                    ),
                  );
                }

                if (state.jobs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.work_off_outlined, size: 80, color: Colors.grey),
                        const SizedBox(height: 20),
                        const Text(
                          "No vacancies posted yet",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _refreshJobs(context),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.jobs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];

                      final String salaryInfo = job.fixedSalary != null
                          ? "${job.fixedSalary} EGP"
                          : (job.minSalary != null ? "${job.minSalary}-${job.maxSalary} EGP" : "Negotiable");

                      return ApplicationCard(
                        name: job.jobTitle,
                        subtitle: "${job.category} . $salaryInfo",
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.indigo),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              builder: (_) => BlocProvider.value(
                                value: context.read<JobBloc>(),
                                child: PostJobScreen(
                                  job: job,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _refreshJobs(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    if (userProvider.token != null) {
      context.read<JobBloc>().add(GetMyJobsEvent(token: userProvider.token!));
    }
  }
}

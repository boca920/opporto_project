import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/home_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/post_job_screen/post_job_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/core/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/post_job_screen/post_job_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/core/provider/user_provider.dart';

class AllJobsScreen extends StatefulWidget {
  const AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  @override
  void initState() {
    super.initState();
    _refreshJobs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state.status == RequestStatus.error && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            CustomHeader(
              title: "My Vacancies",
              isBack: true,
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                  if (state.status == RequestStatus.loading && state.jobs.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.indigo),
                    );
                  }

                  if (state.jobs.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async => _refreshJobs(context),
                      child: ListView(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                          const Center(
                            child: Column(
                              children: [
                                Icon(Icons.work_off_outlined, size: 80, color: Colors.grey),
                                SizedBox(height: 20),
                                Text(
                                  "No vacancies posted yet",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
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
                                  child: PostJobScreen(job: job),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen(index: 1,)) );
        },
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

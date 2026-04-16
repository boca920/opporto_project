import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/calendar_screen/calendar_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/home_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/action_buttons_status.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/cv_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/info_row.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/section_title.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/skills_section.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/status_info.dart';
import 'package:provider/provider.dart';

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
                  InfoRow(label: "Job Title", value: widget.application.jobTitle),
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
                  // نعرض الحالة الحقيقية من الموديل المحدث
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

                  // هنا الهندلة باستخدام الـ Bloc
                  BlocConsumer<JobBloc, JobState>(
                      listener: (context, state) {
                        // 👈 ده أهم سطر: "لو أنا مش الشاشة اللى ظاهرة دلوقتى، متنفذش أى كود"
                        if (!ModalRoute.of(context)!.isCurrent) return;

                        if (state.status == RequestStatus.success) {
                          if (currentStatus == 'Accepted') {
                            final jobBloc = context.read<JobBloc>();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: jobBloc,
                                  child: CalendarScreen(application: widget.application),
                                ),
                              ),
                            );

                            // هنا إنت شلت "الخط الدفاعى التالت" بناءً على طلبك
                            // الـ isCurrent اللى فوق هتقوم بالواجب وتمنع الـ Loop
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Status updated successfully!")
                              ),
                            );
                          }
                        }
                      },
                    builder: (context, state) {
                      if (state.status == RequestStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ActionButtons(
                        statuses: [
                          ApplicationStatus(
                            label: "passed",
                            gradientColors: [const Color(0xFFA9F3A9), const Color(0xFF79AA85)],
                            textColor: Colors.green,
                            borderColor: Colors.green,
                            onTap: () => _handleStatus(context, 'Accepted', state),
                          ),
                          ApplicationStatus(
                            label: "failed",
                            gradientColors: [const Color(0xFFFF5555), const Color(0xFF993333)],
                            textColor: Colors.white,
                            borderColor: Colors.red,
                            onTap: () => _handleStatus(context, 'Rejected', state),
                          ),
                          ApplicationStatus(
                            label: "on hold",
                            gradientColors: [const Color(0xFFF4A014), const Color(0xFFBF7E05)],
                            textColor: const Color(0xFFF69800),
                            borderColor: Colors.white,
                            onTap: () => _handleStatus(context, 'Pending', state),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleStatus(BuildContext context, String newStatus, JobState state) {
    setState(() {
      currentStatus = newStatus;
    });

    // التعديل هنا: ضيف listen: false
    // كدة فلاتر هيفهم إنك عايز القيمة بس مش عايز تراقب التغييرات
    final token = Provider.of<UserProvider>(context, listen: false).token ?? "";

    context.read<JobBloc>().add(
      UpdateApplicationStatusEvent(
        id: widget.application.id,
        status: newStatus,
        token: token,
      ),
    );
    print(widget.application.id);
    print(newStatus);
    print(token);
  }
}
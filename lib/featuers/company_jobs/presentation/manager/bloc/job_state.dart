import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

enum RequestStatus{
  init,
  loading,
  success,
  error,
  idle,
}

class JobState {
  final RequestStatus status;
  final UserModel? userModel;
  final List<JobModel> jobs;
  final List<ApplicationModel> applications;
  final String? message;

  JobState({
    this.status = RequestStatus.init,
    this.userModel,
    this.jobs = const [],
    this.applications = const [],
    this.message,
  });

  // دالة لتسهيل تحديث الحالة
  JobState copyWith({
    RequestStatus? status,
    UserModel? userModel,
    List<JobModel>? jobs,
    List<ApplicationModel>? applications,
    String? message,
  }) {
    return JobState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      jobs: jobs ?? this.jobs,
      applications: applications ?? this.applications,
      message: message ?? this.message,
    );
  }
}
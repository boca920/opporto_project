import 'dart:io';

import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

abstract class JobEvent {}

class AddJobEvent extends JobEvent {
  final JobModel jobData;
  final String userToken;

  AddJobEvent({required this.jobData, required this.userToken});
}
class GetMyJobsEvent extends JobEvent {
  final String token;

  GetMyJobsEvent({required this.token});
}
class GetUserDataEvent extends JobEvent {
  final String userToken;

  GetUserDataEvent({required this.userToken});
}
class UpdateProfileEvent extends JobEvent {
  final String token;
  final String name;
  final String phone;
  final String? about;
  final String? industry;
  final File? imageFile;

  UpdateProfileEvent({
    required this.token,
    required this.name,
    required this.phone,
    this.about,
    this.industry,
    this.imageFile,
  });
}
class GetApplicationsEvent extends JobEvent {
  final String token;

  GetApplicationsEvent({required this.token});
}
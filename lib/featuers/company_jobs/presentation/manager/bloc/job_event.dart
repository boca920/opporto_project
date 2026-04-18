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
class UpdateApplicationStatusEvent extends JobEvent {
  final String id;
  final String status;
  final String token;


  UpdateApplicationStatusEvent({
    required this.id,
    required this.status,
    required this.token,
  });
}
class ScheduleInterviewEvent extends JobEvent {
  final String applicationId;
  final DateTime scheduledAt;
  final String interviewType;
  final String locationOrLink;
  final String token;
  final String? notes;

  ScheduleInterviewEvent({
    required this.applicationId,
    required this.scheduledAt,
    required this.interviewType,
    required this.locationOrLink,
    required this.token,
    this.notes,
  });
}
class GetMyInterviewsEvent extends JobEvent {
  final String token;
  GetMyInterviewsEvent({required this.token});
}
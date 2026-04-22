import 'dart:io';

import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

import '../model/InterviewResponseModel.dart';

abstract class JopDs {
  Future<void> postNewJob(JobModel jobData, String token);
  Future<void> deleteJob(String id, String token);
  Future<JobModel> updateJob({
    required String id,
    required String token,
    required Map<String, dynamic> data,
  });
  Future<List<JobModel>> getMyJobs(String token);
  Future<UserModel> getUserData(String token);
  Future<UserModel> updateProfile({
    required String token,
    required String name,
    required String phone,
    String? about,
    String? industry,
    File? imageFile,
  });

  Future<List<ApplicationModel>> getApplications(String token);
  Future<void> updateApplicationStatus(String id, String status, String token);
  Future<InterviewData> scheduleInterview({
    required String applicationId,
    required DateTime scheduledAt,
    required String interviewType,
    required String locationOrLink,
    required String token,
    String? notes,
  });

  Future<List<InterviewData>> getMyInterviews(String token);
}
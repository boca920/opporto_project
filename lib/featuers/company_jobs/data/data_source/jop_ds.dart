import 'dart:io';

import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

abstract class JopDs {
  Future<void> postNewJob(JobModel jobData, String token);
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
}
import 'dart:io';

import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';

abstract class BaseApplicationRepository {
  Future<ApplicationModel> submitApplication({
    required String jobId,
    required File resumeFile,
    required String token,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String coverLetter,
  });
}
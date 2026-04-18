import 'dart:io';

import 'package:opporto_project/featuers/application/domain/repo/app_repo.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';

class PostApplicationUseCase {
  final BaseApplicationRepository repository;

  PostApplicationUseCase(this.repository);

  Future<ApplicationModel> execute({
    required String jobId,
    required dynamic resume,
    required String token,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String coverLetter,
  }) async {
    return await repository.submitApplication(
      jobId: jobId,
      resumeFile: resume,
      token: token,
      name: name,
      email: email,
      phone: phone,
      address: address,
      coverLetter: coverLetter,
    );
  }
}
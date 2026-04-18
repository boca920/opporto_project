import 'dart:io';
import 'package:dio/dio.dart';
import 'package:opporto_project/featuers/application/data/sources/ds.dart';
import 'package:opporto_project/featuers/application/domain/repo/app_repo.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';

class ApplicationRepository implements BaseApplicationRepository {
  final BaseApplicationRemoteDataSource dataSource;

  ApplicationRepository(this.dataSource);

  @override
  Future<ApplicationModel> submitApplication({required String jobId, required File resumeFile, required String token, required String name, required String email, required String phone, required String address, required String coverLetter}) {
    try{
      return dataSource.submitApplication(jobId: jobId, resumeFile: resumeFile, token: token, name: name, email: email, phone: phone, address: address, coverLetter: coverLetter);
    }catch(e){
      throw Exception(e.toString());
    }

  }


}
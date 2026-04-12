import 'dart:io';

import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/data_source/jop_ds.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class JopRepoImpl implements JopRepo{
  final JopDs jopDs;
  JopRepoImpl({required this.jopDs});


  @override
  Future<void> postNewJob(JobModel jobData, String userToken)async {
    try{
      var res = await jopDs.postNewJob(jobData, userToken);
      return res;
    }catch(e){
      rethrow;
    }

  }

  @override
  Future<UserModel> getUserData(String token) {
    try{
      var res = jopDs.getUserData(token);
      return res;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfile({required String token, required String name, required String phone, String? about, String? industry, File? imageFile}) {
    try{
      var res = jopDs.updateProfile(
          token: token,
          name: name,
           phone: phone,
          about: about,
          industry: industry,
          imageFile: imageFile);
      return res;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<JobModel>>  getMyJobs(String token) async{
  try{
    var res =await jopDs.getMyJobs(token);
    return res;
  }catch(e){
    rethrow;
  }
  }

  @override
  Future<List<ApplicationModel>> getApplications(String token) async{
    try{
      var res =await jopDs.getApplications(token);
      return res;
    }catch(e){
      rethrow;
    }
  }
  }

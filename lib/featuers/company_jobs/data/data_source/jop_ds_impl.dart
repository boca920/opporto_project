import 'dart:io';

import 'package:dio/dio.dart';
import 'package:opporto_project/core/model/user_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/data_source/jop_ds.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

class JopDsImpl implements JopDs {
  String baseUrl = "https://job-backend-mj9t.vercel.app/api/v1";
  final Dio dio;

  JopDsImpl()
      : dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ),
  ) {
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future<void> postNewJob(JobModel jobData, String token) async {
    try {
      var response = await dio.post(
        '$baseUrl/job/post',
        data: jobData.toJson(),
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'application/json',
          },
        ),

      );
      print("TOKEN LENGTH: ${token.length}");
      print("TOKEN: $token");
      if (response.statusCode == 200) {
        print("تمت الإضافة بنجاح!");
      }
    } on DioException catch (e) {
      // 1. اطبع كود الخطأ (هل هو 401 ولا 403؟)
      print("Status Code: ${e.response?.statusCode}");

      // 2. اطبع الرد الحقيقي بتاع السيرفر (ده اللي فيه الحل)
      print("Server Error Message: ${e.response?.data}");

      // 3. اطبع التوكن اللي مبعوث عشان نتأكد إنه مش null
      print("Sent Token: $token");
    }
  }

  @override
  Future<UserModel> getUserData(String token) async {
    try {
      var response = await dio.get(
        '$baseUrl/user/getuser',
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfile({
    required String token,
    required String name,
    required String phone,
    String? about,
    String? industry,
    File? imageFile,
  }) async {
    try {
      Map<String, dynamic> dataMap = {
        'userName': name,
        'phoneNumber': phone,
        'description': about,
        'category': industry,
      };


      if (imageFile != null) {
        dataMap['image'] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path
              .split('/')
              .last,
        );
      }

      var formData = FormData.fromMap(dataMap);

      var response = await dio.put(

        '$baseUrl/user/update-profile',
        data: formData,
        options: Options(
          headers: {
            'Cookie': 'token=$token',

          },
        ),
      );

      print("UPDATE_SUCCESS_DATA: ${response.data}");


      if (response.data['user'] != null) {
        return UserModel.fromJson(response.data['user']);
      } else {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print("UPDATE_ERROR_DATA: ${e.response?.data}");
      }
      rethrow;
    }
  }

  @override
  Future<List<JobModel>> getMyJobs(String token) async {
    try {
      var response = await dio.get(
          '$baseUrl/job/getmyjobs',
          options: Options(
            headers: {
              'Cookie': 'token=$token',
              'Content-Type': 'application/json',
            },
          )
      );
      final List jobsData = response.data['myJobs'];
      return jobsData.map((e) => JobModel.fromJson(e)).toList();
    } catch (e) {
      if (e is DioException) {
        print("UPDATE_ERROR_DATA: ${e.response?.data}");
      }
      rethrow;
    }
  }

  @override
  Future<List<ApplicationModel>> getApplications(String token) async {
    try {
      var response = await dio.get(
        '$baseUrl/application/employer/getall',
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data is List) {
        final List applicationsData = response.data;
        return applicationsData
            .map((e) => ApplicationModel.fromJson(e))
            .toList();
      } else {
        final List applicationsData = response.data['applications'] ?? [];
        return applicationsData
            .map((e) => ApplicationModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      if (e is DioException) {
        print("API_ERROR_DATA: ${e.response?.data}");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateApplicationStatus(String id, String status, String token)async {
   try{
    await dio.put(
       '$baseUrl/application/updatestatus/$id',
       data: {"status": status},
       options: Options(headers: {'Cookie': 'token=$token'}),
     );

   }catch(e){
     rethrow;
   }
  }

  @override
  Future<InterviewData> scheduleInterview({
    required String applicationId,
    required DateTime scheduledAt,
    required String interviewType,
    required String locationOrLink,
    required String token,
    String? notes,
  }) async {
    try {
      final response = await dio.post(
          '$baseUrl/interview/schedule',
          data: {
            // تأكد لو السيرفر مستني applicationId أو application بس
            "applicationId": applicationId,
            "scheduledAt":  scheduledAt.toIso8601String(),
            "interviewType": interviewType,
            "locationOrLink": locationOrLink,
            "notes": notes ?? "Scheduled via app",
          },
          options: Options(
            headers: {
              'Cookie': 'token=$token',
              'Content-Type': 'application/json',
            },
          )
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return InterviewData.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? "Error scheduling interview");
      }
    } on DioException catch (e) {
      print("========== DIO ERROR ==========");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("URL: ${e.requestOptions.path}");
      print("================================");

      throw Exception("Network error occurred");
    }
  }

  @override
  Future<List<InterviewData>> getMyInterviews(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/interview/my',
        options: Options(
          headers: {
            'Cookie': 'token=$token',
          },
        ),
      );

      if (response.data['success'] == true) {
        List data = response.data['interviews'] ?? [];

        return data
            .map((e) => InterviewData.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      print("❌ Error fetching interviews: $e");
      throw Exception("Failed to load interviews");
    }
  }

}
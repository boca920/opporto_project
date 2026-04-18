import 'dart:io';
import 'package:dio/dio.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';

abstract class BaseApplicationRemoteDataSource {
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

class ApplicationRemoteDataSource implements BaseApplicationRemoteDataSource {
  final Dio dio;

  ApplicationRemoteDataSource(this.dio);

  @override
  Future<ApplicationModel> submitApplication({
    required String jobId,
    required File resumeFile,
    required String token,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String coverLetter,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "jobId": jobId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "coverLetter": coverLetter,
        "resume": await MultipartFile.fromFile(
          resumeFile.path,
          filename: resumeFile.path.split('/').last,
        ),
      });

      final response = await dio.post(
        "https://job-backend-mj9t.vercel.app/api/v1/application/post",
        data: formData,
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE: ${response.data}");
      return ApplicationModel.fromJson(response.data);
    } on DioException catch (e) {
      print("❌ ERROR STATUS: ${e.response?.statusCode}");
      print("❌ ERROR DATA: ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? "Network Error");
    }
  }
}
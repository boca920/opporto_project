import 'package:dio/dio.dart';
import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';

abstract class NotificationDataSource {
  Future<NotificationResponseModel> getMyNotifications(String token);
  Future<void> asRead(String id,String token);
  Future<void> allAsRead(String token);
}

class NotificationDataSourceImpl implements NotificationDataSource {
  String baseUrl = "https://job-backend-mj9t.vercel.app/api/v1";
  final Dio dio;
  NotificationDataSourceImpl(this.dio);

  @override
  Future<NotificationResponseModel> getMyNotifications(String token) async {
    try {
      print("🚀 Sending Request with Token: $token");
      final response = await dio.get(
          '$baseUrl/notification/my',
          options: Options(
            headers: {
              'Cookie': 'token=$token',
              'Content-Type': 'application/json',
            },
          )
      );
      print("Response Data: ${response.data}");
      return NotificationResponseModel.fromJson(response.data);
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to fetch notifications");
    }
  }

  @override
  Future<void> asRead(String id,String token) async {
    await dio.patch(
        '$baseUrl/notification/read/$id',
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'application/json',
          },
        )
    );
  }

  @override
  Future<void> allAsRead( String token) async {
    await dio.patch('$baseUrl/notification/read-all',
        options: Options(
          headers: {
            'Cookie': 'token=$token',
            'Content-Type': 'application/json',
          },
        )
    );
  }
}
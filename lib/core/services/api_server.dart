import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // ✅ Base URL ذكي يعمل على كل المنصات
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:4000';  // Web browser
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:4000';   // Android Emulator
    } else {
      return 'http://localhost:4000';   // iOS / Desktop
    }
  }

  static const String apiPrefix = '/api/v1';
  static const Duration timeout = Duration(seconds: 15);

  // Get Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // ✅ Post Job - مُصحح حسب الـ API Response
  static Future<Map<String, dynamic>> postJob(Map<String, dynamic> data) async {
    final token = await getToken();
    if (token == null) throw Exception('No token found. Please login first.');

    try {
      print('📤 POSTING to: $baseUrl$apiPrefix/job/post');
      print('📤 Job data: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse('$baseUrl$apiPrefix/job/post'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      ).timeout(timeout);

      print('📥 Post Job Response: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        return {
          'success': true,
          'data': responseData['job'] // ✅ الـ job object من الـ response
        };
      }

      throw Exception(responseData['message'] ?? 'Failed to post job');
    } catch (e) {
      print('❌ Post Job Error: $e');
      rethrow;
    }
  }

  // ✅ Get All Jobs - مُصحح حسب الـ API Response
  static Future<List<dynamic>> getAllJobs() async {
    try {
      print('🔍 GETTING all jobs from: $baseUrl$apiPrefix/job/getall');

      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/job/getall'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeout);

      print('📥 Get All Jobs Response: ${response.statusCode}');
      print('📥 Jobs count: ${jsonDecode(response.body)['jobs']?.length ?? 0}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        return List<dynamic>.from(responseData['jobs'] ?? []);
      }
      throw Exception(responseData['message'] ?? 'Failed to fetch all jobs');
    } catch (e) {
      print('❌ Get All Jobs Error: $e');
      rethrow;
    }
  }

  // ✅ Get My Jobs
  static Future<List<dynamic>> getMyJobs() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/job/getmyjobs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeout);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        return List<dynamic>.from(responseData['myJobs'] ?? []);
      }
      throw Exception(responseData['message'] ?? 'Failed to fetch my jobs');
    } catch (e) {
      print('❌ Get My Jobs Error: $e');
      rethrow;
    }
  }

  // Test Connection
  // 👈 غيّر هذه الدالة فقط
  static Future<Map<String, dynamic>> testConnection() async {
    try {
      print('🧪 Testing Jobs endpoint: $baseUrl$apiPrefix/job/getall');

      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/job/getall'),  // 👈 استخدم job/getall بدلاً من /api/v1
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 5));

      print('📥 Test Response: ${response.statusCode}');

      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'endpoint': '/job/getall',
        'baseUrl': baseUrl,
        'jobsCount': jsonDecode(response.body)['jobs']?.length ?? 0,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
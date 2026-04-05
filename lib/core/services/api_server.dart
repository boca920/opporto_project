import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opporto_project/core/config/app_config.dart';

class ApiService {

  static String get baseUrl => AppConfig.apiBaseUrl;

  static const String apiPrefix = AppConfig.apiPrefix;
  static const Duration timeout = Duration(seconds: 15);

  // Get Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.trim().isNotEmpty) return token.trim();


    final legacy = prefs.getString('authToken');
    if (legacy != null && legacy.trim().isNotEmpty) return legacy.trim();

    return null;
  }


  static Future<Map<String, dynamic>> postJob(Map<String, dynamic> data) async {
    final token = await getToken();
    if (token == null) throw Exception('No token found. Please login first.');

    try {
      print(' Token length (postJob): ${token.length}');
      print(' Token prefix (postJob): ${token.substring(0, token.length > 18 ? 18 : token.length)}');
      print(' POSTING to: $baseUrl$apiPrefix/job/post');
      print(' Job data: ${jsonEncode(data)}');

      Future<http.Response> doPost({required bool useBearer}) {
        return http
            .post(
              Uri.parse('$baseUrl$apiPrefix/job/post'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': useBearer ? 'Bearer $token' : token,
              },
              body: jsonEncode(data),
            )
            .timeout(timeout);
      }

      // Try Bearer first (most common), then retry raw token on 401/403.
      var response = await doPost(useBearer: true);
      if (response.statusCode == 401 || response.statusCode == 403) {
        print(' Retry POST /job/post using raw token');
        response = await doPost(useBearer: false);
      }

      print('Post Job Response: ${response.statusCode}');
      print(' Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      final isSuccessStatus = response.statusCode >= 200 && response.statusCode < 300;

      if (isSuccessStatus && responseData['success'] == true) {
        final jobObj = responseData['job'] ??
            (responseData['data'] is Map<String, dynamic>
                ? responseData['data']
                : responseData['data']);
        return {
          'success': true,
          'data': jobObj,
        };
      }

      throw Exception(responseData['message'] ?? 'Failed to post job');
    } catch (e) {
      print(' Post Job Error: $e');
      rethrow;
    }
  }

  static Future<List<dynamic>> getAllJobs() async {
    try {
      print('🔍 GETTING all jobs from: $baseUrl$apiPrefix/job/getall');

      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/job/getall'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeout);

      print(' Get All Jobs Response: ${response.statusCode}');
      print(' Get All Jobs Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      final isSuccessStatus = response.statusCode >= 200 && response.statusCode < 300;

      if (isSuccessStatus && responseData['success'] == true) {
        final jobsRaw = responseData['jobs'] ??
            (responseData['data'] is Map<String, dynamic>
                ? responseData['data']['jobs']
                : responseData['data']);

        final jobsList = jobsRaw is List
            ? jobsRaw
            : (jobsRaw is Map<String, dynamic> ? jobsRaw['jobs'] : null);

        print('📥 Parsed jobs count: ${jobsList is List ? jobsList.length : 0}');
        return List<dynamic>.from(jobsList ?? []);
      }
      throw Exception(responseData['message'] ?? 'Failed to fetch all jobs');
    } catch (e) {
      print('Get All Jobs Error: $e');
      rethrow;
    }
  }


  static Future<List<dynamic>> getMyJobs() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');

    try {
      Future<http.Response> doGet({required bool useBearer}) {
        return http
            .get(
              Uri.parse('$baseUrl$apiPrefix/job/getmyjobs'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': useBearer ? 'Bearer $token' : token,
              },
            )
            .timeout(timeout);
      }

      var response = await doGet(useBearer: true);
      if (response.statusCode == 401 || response.statusCode == 403) {
        print(' Retry GET /job/getmyjobs using raw token');
        response = await doGet(useBearer: false);
      }

      final responseData = jsonDecode(response.body);

      final isSuccessStatus = response.statusCode >= 200 && response.statusCode < 300;

      if (isSuccessStatus && responseData['success'] == true) {
        final myJobs = responseData['myJobs'] ??
            (responseData['data'] is Map<String, dynamic>
                ? responseData['data']['myJobs']
                : responseData['data']);
        return List<dynamic>.from(myJobs ?? []);
      }
      throw Exception(responseData['message'] ?? 'Failed to fetch my jobs');
    } catch (e) {
      print('Get My Jobs Error: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> testConnection() async {
    try {
      print(' Testing Jobs endpoint: $baseUrl$apiPrefix/job/getall');

      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/job/getall'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 5));

      print(' Test Response: ${response.statusCode}');

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
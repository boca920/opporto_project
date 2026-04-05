import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class NotificationService {
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.trim().isNotEmpty) return token.trim();
    final legacy = prefs.getString('authToken');
    if (legacy != null && legacy.trim().isNotEmpty) return legacy.trim();
    return null;
  }

  static Map<String, String> _buildAuthHeaders({
    required String token,
    required bool useBearer,
  }) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': useBearer ? 'Bearer $token' : token,
    };
  }

  static Future<http.Response> _fetchMyNotifications({
    required String token,
    required bool useBearer,
  }) {
    return http.get(
      Uri.parse(
        '${AppConfig.apiBaseUrl}${AppConfig.apiPrefix}/notification/my',
      ),
      headers: _buildAuthHeaders(token: token, useBearer: useBearer),
    );
  }

  static Future<List<dynamic>> getMyNotifications() async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return [];


    print(' Fetch notifications using Authorization: Bearer (len=${token.length})');
    final response = await _fetchMyNotifications(token: token, useBearer: true);

    // If backend rejects the header format, retry with raw token.
    if (response.statusCode == 401 || response.statusCode == 403) {
      print(' Retrying notifications using raw token (len=${token.length})');
      final retry = await _fetchMyNotifications(token: token, useBearer: false);
      if (retry.statusCode < 200 || retry.statusCode >= 300) {
        throw Exception(
          'Failed to fetch notifications: ${retry.body}',
        );
      }
      return _parseNotificationsResponse(retry.body);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to fetch notifications: ${response.body}');
    }

    return _parseNotificationsResponse(response.body);
  }

  static List<dynamic> _parseNotificationsResponse(String body) {
    final data = jsonDecode(body);

    if (data is List) return data;

    final candidate = data['notifications'] ??
        data['myNotifications'] ??
        data['items'] ??
        data['data'] ??
        (data['data'] is Map<String, dynamic>
            ? data['data']['notifications']
            : null);

    if (candidate is List) return candidate;
    if (candidate is Map<String, dynamic> && candidate['notifications'] is List) {
      return List<dynamic>.from(candidate['notifications'] as List);
    }
    return [];
  }

  static Future<void> markAllRead() async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return;

    final response = await http.patch(
      Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.apiPrefix}/notification/read-all'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Some backends might return 200/204 without body.
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to mark notifications as read: ${response.body}');
    }
  }

  static Future<void> markReadById(String id) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) return;

    final response = await http.patch(
      Uri.parse(
          '${AppConfig.apiBaseUrl}${AppConfig.apiPrefix}/notification/read/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to mark notification as read: ${response.body}');
    }
  }
}


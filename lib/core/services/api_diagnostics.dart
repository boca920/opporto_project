import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class ApiDiagnostics {
  static Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.trim().isNotEmpty) return token.trim();
    final legacy = prefs.getString('authToken');
    if (legacy != null && legacy.trim().isNotEmpty) return legacy.trim();
    return null;
  }

  static String _shortBody(String body, {int max = 350}) {
    final s = body.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (s.length <= max) return s;
    return '${s.substring(0, max)}...';
  }

  static Future<void> run() async {
    final base = '${AppConfig.apiBaseUrl}${AppConfig.apiPrefix}';
    final token = await _token();

    Future<void> probe({
      required String name,
      required Future<http.Response> Function() request,
    }) async {
      try {
        final res = await request();
        print('🧪 API $name -> ${res.statusCode} | ${_shortBody(res.body)}');
      } catch (e) {
        print('🧪 API $name -> ERROR | $e');
      }
    }

    print('🧪 API diagnostics started. base=$base tokenLen=${token?.length ?? 0}');

    await probe(
      name: 'GET /job/getall (public)',
      request: () => http.get(Uri.parse('$base/job/getall')),
    );

    if (token == null) {
      print('🧪 API diagnostics: no token found, skipping auth endpoints.');
      return;
    }

    final authHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await probe(
      name: 'GET /user/getuser (auth)',
      request: () => http.get(Uri.parse('$base/user/getuser'), headers: authHeaders),
    );

    await probe(
      name: 'GET /notification/my (auth)',
      request: () =>
          http.get(Uri.parse('$base/notification/my'), headers: authHeaders),
    );

    await probe(
      name: 'GET /job/getmyjobs (auth)',
      request: () => http.get(Uri.parse('$base/job/getmyjobs'), headers: authHeaders),
    );

    // Optional: validate JSON shape quickly
    await probe(
      name: 'GET /job/getall JSON parse',
      request: () async {
        final res = await http.get(Uri.parse('$base/job/getall'));
        jsonDecode(res.body);
        return res;
      },
    );

    print('🧪 API diagnostics finished.');
  }
}


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://10.0.2.2:4000/api/v1";
  static const int timeoutSeconds = 20;

  // ================= REGISTER =================
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      print('📤 Register Request: name=$name, email=$email, role=$role');

      final response = await http
          .post(
        Uri.parse('$baseUrl/user/register'),
        headers: _defaultHeaders(),
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim().toLowerCase(),
          'phone': phone.trim(),
          'password': password,
          'role': role,
        }),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print('📥 Register Response: ${response.statusCode} - ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print('❌ Register Error: $e');
      return _genericError('التسجيل', e);
    }
  }

  // ================= LOGIN - مُصحح ✅ =================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    String? role, // ✅ Optional role
  }) async {
    try {
      print('📤 Login Request: email=$email');

      // ✅ بناء الـ body حسب الـ backend
      Map<String, dynamic> body = {
        'email': email.trim().toLowerCase(),
        'password': password,
      };

      // ✅ إضافة role لو موجود
      if (role != null && role.isNotEmpty) {
        body['role'] = role;
      }

      final response = await http
          .post(
        Uri.parse('$baseUrl/user/login'),
        headers: _defaultHeaders(),
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print('📥 Login Response: ${response.statusCode}');
      print('📥 Login Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Login Error: $e');
      return _genericError('تسجيل الدخول', e);
    }
  }

  // ================= LOGOUT =================
  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/logout'),
        headers: {
          ..._defaultHeaders(),
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } catch (e) {
      return {'success': true, 'message': 'تم تسجيل الخروج محلياً'};
    }
  }

  // ================= GET USER =================
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/getuser'),
        headers: {
          ..._defaultHeaders(),
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: timeoutSeconds));

      return _handleResponse(response);
    } catch (e) {
      return _genericError('جلب بيانات الملف الشخصي', e);
    }
  }

  // ================= Helpers =================
  static Map<String, String> _defaultHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      print('🔍 Response Status: ${response.statusCode}');
      print('🔍 Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': data,
          'message': data['message'] ?? 'نجح العملية'
        };
      } else {
        String errorMsg = 'خطأ في الخادم (${response.statusCode})';

        if (data['message'] != null) {
          errorMsg = data['message'];

          // ✅ رسائل خطأ مخصصة
          if (data['message'].toString().contains('Email already registered')) {
            errorMsg = 'الإيميل مسجل مسبقاً';
          } else if (data['message'].toString().contains('Invalid credentials')) {
            errorMsg = 'إيميل أو كلمة مرور خاطئة';
          } else if (data['message'].toString().contains('User with role')) {
            errorMsg = 'لا يوجد حساب بهذا الدور';
          }
        }

        return {'success': false, 'message': errorMsg};
      }
    } catch (e) {
      print('❌ Parse Error: $e');
      return {'success': false, 'message': 'خطأ في تحليل البيانات: ${e.toString()}'};
    }
  }

  static Map<String, dynamic> _genericError(String operation, dynamic e) => {
    'success': false,
    'message': 'خطأ في $operation: ${e.toString()}',
  };
}
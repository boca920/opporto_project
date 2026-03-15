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

  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    String? role,
  }) async {
    try {
      print('📤 Login Request: email=$email');

      Map<String, dynamic> body = {
        'email': email.trim().toLowerCase(),
        'password': password,
      };

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

  // ================= NEW: FORGOT PASSWORD (OTP) ✅ =================
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      print('📤 Forgot Password Request: email=$email');

      final response = await http
          .post(
        Uri.parse('$baseUrl/user/forgot-password'),
        headers: _defaultHeaders(),
        body: jsonEncode({
          'email': email.trim().toLowerCase(),
        }),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print('📥 Forgot Password Response: ${response.statusCode} - ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print('❌ Forgot Password Error: $e');
      return _genericError('إرسال كود التحقق', e);
    }
  }

  // ================= NEW: RESET PASSWORD OTP ✅ =================
  static Future<Map<String, dynamic>> resetPasswordOtp({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      print('📤 Reset Password OTP: email=$email');

      final response = await http
          .put(
        Uri.parse('$baseUrl/user/reset-password'),
        headers: _defaultHeaders(),
        body: jsonEncode({
          'email': email.trim().toLowerCase(),
          'otp': otp.trim(),
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print('📥 Reset Password OTP Response: ${response.statusCode}');
      print('📥 Reset Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Reset Password OTP Error: $e');
      return _genericError('إعادة تعيين كلمة المرور', e);
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

          // ✅ OTP-specific error messages
          if (data['message'].toString().contains('User not found')) {
            errorMsg = 'لا يوجد حساب بهذا الإيميل';
          } else if (data['message'].toString().contains('OTP expired')) {
            errorMsg = 'انتهت صلاحية الكود، اطلب كود جديد';
          } else if (data['message'].toString().contains('Invalid OTP')) {
            errorMsg = 'كود التحقق خاطئ';
          } else if (data['message'].toString().contains('Email could not be sent')) {
            errorMsg = 'فشل إرسال الكود، جرب مرة أخرى';
          } else if (data['message'].toString().contains('Passwords do not match')) {
            errorMsg = 'كلمات المرور غير متطابقة';
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
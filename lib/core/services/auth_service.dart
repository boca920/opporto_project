import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opporto_project/core/config/app_config.dart';

class AuthService {
  static String get baseUrl => '${AppConfig.apiBaseUrl}${AppConfig.apiPrefix}';
  static const int timeoutSeconds = 20;


  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rolePreference,
  }) async {
    try {
      print('Register Request: name=$name, email=$email, phone=$phone, role=$rolePreference');

      final response = await http
          .post(
        Uri.parse('$baseUrl/user/register'),
        headers: _defaultHeaders(),
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim().toLowerCase(),
          'phone': phone.trim(),
          'password': password,
          'role': rolePreference,
        }),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print(' Register Response: ${response.statusCode}');
      print(' Response Body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print(' Register Error: $e');
      return _genericError('التسجيل', e);
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    String? role,
  }) async {
    try {
      print(' Login Request: email=$email, role=$role');

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
      return _handleResponse(response);
    } catch (e) {
      print(' Login Error: $e');
      return _genericError('تسجيل الدخول', e);
    }
  }

  static Future<Map<String, dynamic>> verifyEmail({required String token}) async {
    try {
      print('Verify Email: $token');
      final response = await http
          .get(
        Uri.parse('$baseUrl/user/verify-email/$token'),
        headers: _defaultHeaders(),
      )
          .timeout(const Duration(seconds: timeoutSeconds));
      return _handleResponse(response);
    } catch (e) {
      return _genericError('التحقق من البريد الإلكتروني', e);
    }
  }


  static Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      print('Forgot Password: $email');
      final response = await http
          .post(
        Uri.parse('$baseUrl/user/forgot-password'),
        headers: _defaultHeaders(),
        body: jsonEncode({'email': email.trim().toLowerCase()}),
      )
          .timeout(const Duration(seconds: timeoutSeconds));
      return _handleResponse(response);
    } catch (e) {
      return _genericError('إرسال كود التحقق', e);
    }
  }


  static Future<Map<String, dynamic>> resetPasswordOtp({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      print(' Reset Password OTP: $email');
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
      return _handleResponse(response);
    } catch (e) {
      return _genericError('إعادة تعيين كلمة المرور', e);
    }
  }


  static Future<Map<String, dynamic>> requestOtp(String token) async {
    try {
      print(' Request OTP');
      final response = await http
          .post(
        Uri.parse('$baseUrl/user/otp/request'),
        headers: {
          ..._defaultHeaders(),
          'Authorization': 'Bearer $token',
        },
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print(' Request OTP Response: ${response.statusCode}');
      print('OTP Response: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print(' Request OTP Error: $e');
      return _genericError('طلب كود التحقق', e);
    }
  }


  static Future<Map<String, dynamic>> verifyOtp(String token, {required String otp}) async {
    try {
      print(' Verify OTP: $otp');
      final response = await http
          .post(
        Uri.parse('$baseUrl/user/otp/verify'),
        headers: {
          ..._defaultHeaders(),
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'otp': otp.trim(),
        }),
      )
          .timeout(const Duration(seconds: timeoutSeconds));

      print('Verify OTP Response: ${response.statusCode}');
      print('OTP Verification: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      print('Verify OTP Error: $e');
      return _genericError('التحقق من كود OTP', e);
    }
  }

  // ================= LOGOUT =================
  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/logout'),
        headers: {..._defaultHeaders(), 'Authorization': 'Bearer $token'},
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
        headers: {..._defaultHeaders(), 'Authorization': 'Bearer $token'},
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
      print(' Raw Response: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': data['data'] ?? data,
          'message': data['message'] ?? 'نجح العملية'
        };
      } else {
        return {
          'success': false,
          'message': _parseErrorMessage(data['message'] ?? 'خطأ في الخادم')
        };
      }
    } catch (e) {
      print(' Parse Error: $e');
      print('Response Body: ${response.body}');
      return {'success': false, 'message': 'خطأ في تحليل البيانات: ${e.toString()}'};
    }
  }

  static String _parseErrorMessage(String? message) {
    if (message == null) return 'خطأ غير معروف';

    final msg = message.toString().toLowerCase();

    if (msg.contains('email already exists') || msg.contains('duplicate key')) {
      return 'هذا الإيميل مسجل مسبقاً';
    }
    if (msg.contains('user not found')) return 'لا يوجد حساب بهذا الإيميل';
    if (msg.contains('invalid role')) return 'الدور غير صحيح';
    if (msg.contains('skills')) return 'المهارات غير صحيحة';
    if (msg.contains('phone')) return 'رقم الهاتف غير صحيح';
    if (msg.contains('otp expired')) return 'انتهت صلاحية كود التحقق';
    if (msg.contains('invalid otp')) return 'كود التحقق خاطئ';
    if (msg.contains('email could not be sent')) return 'فشل إرسال البريد الإلكتروني';
    if (msg.contains('passwords do not match')) return 'كلمات المرور غير متطابقة';
    if (msg.contains('invalid token')) return 'الرابط غير صحيح أو منتهي الصلاحية';
    if (msg.contains('email not verified')) return 'يرجى التحقق من بريدك الإلكتروني أولاً';

    return message;
  }

  static Map<String, dynamic> _genericError(String operation, dynamic e) => {
    'success': false,
    'message': 'خطأ في $operation: ${e.toString()}',
  };
}
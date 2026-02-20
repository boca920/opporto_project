import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserData({
    required String fullName,
    required String address,
    required String phone,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString('address', address);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);
  }

  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString('fullName') ?? '',
      'address': prefs.getString('address') ?? '',
      'phone': prefs.getString('phone') ?? '',
      'email': prefs.getString('email') ?? '',
    };
  }
}
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _user;
  String? _token;

  Map<String, dynamic>? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty && _user != null;
  String? get role => _user?['role'];
  String? get name => _user?['name'];
  String? get email => _user?['email'];
  String? get phone => _user?['phone'];

  // ✅ محسن لكل الحالات
  bool get isJobSeeker => _isRole(['Job Seeker', 'job_seeker', 'jobseeker']);
  bool get isEmployer => _isRole(['Employer', 'employer', 'company']);

  bool _isRole(List<String> roles) {
    final userRole = role?.toString().toLowerCase();
    return roles.any((r) => userRole == r.toLowerCase());
  }

  Future<void> setUser(Map<String, dynamic> userData, String? token) async {
    print('👤 UserProvider - Setting user: ${userData['name']}');
    print('👤 Role from API: ${userData['role']}');
    print('👤 Token length: ${token?.length ?? 0}');

    _user = userData;
    _token = token;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token ?? '');
      await prefs.setString('user', jsonEncode(userData));

      if (userData['role'] != null) {
        await prefs.setString('role', userData['role']);
      }

      print('✅ UserProvider - User saved successfully');
      print('✅ isJobSeeker: $isJobSeeker');
      print('✅ isEmployer: $isEmployer');
    } catch (e) {
      print('❌ UserProvider save error: $e');
    }

    notifyListeners();
  }

  Future<void> logout() async {
    print('👤 UserProvider - Logging out...');
    _user = null;
    _token = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('role');

    notifyListeners();
  }

  Future<void> loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userJson = prefs.getString('user');

    if (token != null && token.isNotEmpty && userJson != null) {
      try {
        _token = token;
        _user = jsonDecode(userJson);
        print('👤 UserProvider - Loaded: ${_user?['name']} (${_user?['role']})');
        notifyListeners();
      } catch (e) {
        print('❌ Load error: $e');
        await clearStoredData();
      }
    }
  }

  Future<void> clearStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('role');
    _user = null;
    _token = null;
    notifyListeners();
  }

  Future<void> updateUser(Map<String, dynamic> updatedUser) async {
    _user = updatedUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(updatedUser));
    notifyListeners();
  }
}
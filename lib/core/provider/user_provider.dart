import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _user;
  String? _token;

  Map<String, dynamic>? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _user != null;

  Future<void> setUser(Map<String, dynamic> userData, String? token) async {
    _user = userData;
    _token = token;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token ?? '');
    await prefs.setString('user', jsonEncode(userData));

    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');

    notifyListeners();
  }

  Future<void> loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userJson = prefs.getString('user');

    if (token != null && userJson != null) {
      try {
        _token = token;
        _user = jsonDecode(userJson);
        notifyListeners();
      } catch (e) {
        await prefs.remove('token');
        await prefs.remove('user');
      }
    }
  }
}
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String role = "user"; // القيمة الافتراضية
  String fullName = "";
  String email = "";
  String phone = "";
  String address = "";

  // تعيين الدور
  void setRole(String newRole) {
    role = newRole;
    notifyListeners();
  }

  // تحديث بيانات المستخدم
  void updateUser({
    required String fullName,
    required String email,
    required String phone,
    required String address,
  }) {
    this.fullName = fullName;
    this.email = email;
    this.phone = phone;
    this.address = address;
    notifyListeners();
  }
}
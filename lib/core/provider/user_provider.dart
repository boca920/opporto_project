import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String fullName = "";
  String email = "";
  String phone = "";
  String address = "";

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

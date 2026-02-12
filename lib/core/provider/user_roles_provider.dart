import 'package:flutter/material.dart';

class UserRolesProvider extends ChangeNotifier {
  List<String> _selectedRoles = [];

  List<String> get selectedRoles => _selectedRoles;

  void setRoles(List<String> roles) {
    _selectedRoles = roles;
    notifyListeners();
  }
}

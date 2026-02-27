import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_provider.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return DropdownButton<String>(
      value: userProvider.role,
      isExpanded: true,
      items: const [
        DropdownMenuItem(value: "user", child: Text("User")),
        DropdownMenuItem(value: "company", child: Text("Company")),
      ],
      onChanged: (value) {
        if (value != null) {
          userProvider.setRole(value);
        }
      },
    );
  }
}
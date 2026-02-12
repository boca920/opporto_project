import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_roles_provider.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRoles =
        Provider.of<UserRolesProvider>(context).selectedRoles;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            const SizedBox(height: 15),
            const Text(
              "John Carter",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "johncarter@email.com",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // عرض الأدوار
            if (selectedRoles.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedRoles
                    .map((role) => Chip(
                  label: Text(role),
                  backgroundColor: Colors.blue.shade100,
                ))
                    .toList(),
              ),
            const SizedBox(height: 20),

            const Expanded(child: Center(child: Text("More profile content here"))),
          ],
        ),
      ),
    );
  }
}

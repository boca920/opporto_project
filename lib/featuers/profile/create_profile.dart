import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/widget/nav_bar.dart';
import 'profile_view.dart';


class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  List<String> roles = [
    "UI / UX",
    "Developer",
    "Marketing",
    "Designer",
    "Project Manager",
    "Web Designer",
    "Flutter Developer",
    "Backend Developer",
    "Frontend Developer",
    "Graphic Designer",
    "Content Creator",
    "SEO Specialist",
    "Social Media Manager",
    "Product Manager",
    "Data Analyst",
  ];

  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(roles.length, (index) {
                    final isSelected = selectedIndexes.contains(index);
                    return FilterChip(
                      selected: isSelected,
                      showCheckmark: false,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey.shade200,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedIndexes.add(index);
                          } else {
                            selectedIndexes.remove(index);
                          }
                        });
                      },
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            roles[index],
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black),
                          ),
                          const SizedBox(width: 6),
                          isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 18)
                              : const Icon(Icons.add, color: Colors.black54, size: 18),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // تخزين البيانات في الـ Provider
                Provider.of<UserRolesProvider>(context, listen: false).setRoles(
                    selectedIndexes.map((i) => roles[i]).toList());

                // الانتقال إلى الصفحة الرئيسية مع NavBar
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AnimatedNavBar(),
                  ),
                );
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

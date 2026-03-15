import 'package:flutter/material.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/widget/nav_bar.dart';

class CreateProfile extends StatefulWidget {
  final String fullName;
  final String email;
  final String phone;
  final String address;

  const CreateProfile({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _controller = TextEditingController();

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
    "Data Analyst"
  ];

  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("Create Profile", style: AppFonts.blackmeduim24),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              AppAssets.profile,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TextField لإضافة دور جديد
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Add a role manually",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (_controller.text.trim().isEmpty) return;
                            setState(() {
                              roles.add(_controller.text.trim());
                              selectedIndexes.add(roles.length - 1);
                              _controller.clear();
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isEmpty) return;
                        setState(() {
                          roles.add(value.trim());
                          selectedIndexes.add(roles.length - 1);
                          _controller.clear();
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Wrap للقائمة الحالية
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(roles.length, (index) {
                        final isSelected =
                        selectedIndexes.contains(index);
                        return FilterChip(
                          selected: isSelected,
                          showCheckmark: false,
                          selectedColor: AppColors.movColor,
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
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(width: 6),
                              isSelected
                                  ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                                  : const Icon(Icons.add,
                                  color: Colors.black54, size: 18),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            CustomButtom(
              text: "Next",
              onTap: () {
                Provider.of<UserRolesProvider>(context, listen: false)
                    .setRoles(
                    selectedIndexes.map((i) => roles[i]).toList());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AnimatedNavBar(
                      initialIndex: 3,
                    ),
                  ),
                );
              },
              color: AppColors.movColor,
              borderColor: AppColors.movColor,
              width: width * 0.88,
              height: height * 0.06,
              textStyle: AppFonts.whitemedium16,
            ),
          ],
        ),
      ),
    );
  }
}
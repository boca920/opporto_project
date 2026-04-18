import 'package:flutter/material.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/widget/nav_bar.dart';
import 'profile_view.dart';

class CreateProfile extends StatefulWidget {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String? role;

  const CreateProfile({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.role,
  });

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _skillController = TextEditingController();
  final FocusNode _skillFocus = FocusNode();

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

  void _addCustomSkill() {
    final newSkill = _skillController.text.trim();
    if (newSkill.isEmpty) return;

    final exists = roles.any(
          (skill) => skill.toLowerCase() == newSkill.toLowerCase(),
    );

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This skill already exists'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      roles.add(newSkill);
      selectedIndexes.add(roles.length - 1); // select it directly
    });

    _skillController.clear();
    _skillFocus.requestFocus();
  }

  @override
  void dispose() {
    _skillController.dispose();
    _skillFocus.dispose();
    super.dispose();
  }

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

            // Add custom skill input
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _skillController,
                    focusNode: _skillFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _addCustomSkill(),
                    decoration: InputDecoration(
                      hintText: 'Add your skill manually',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.movColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _addCustomSkill,
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.movColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

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
                              color: isSelected ? Colors.white : Colors.black,
                            ),
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
            SizedBox(height: height * 0.02),
            CustomButtom(
              text: "Next",
              onTap: () {
                Provider.of<UserRolesProvider>(context, listen: false)
                    .setRoles(selectedIndexes.map((i) => roles[i]).toList());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnimatedNavBar(
                      initialIndex: 0,
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
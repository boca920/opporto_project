import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';
import 'package:opporto_project/featuers/home/home_view.dart';

class CVFormView extends StatefulWidget {
  const CVFormView({super.key});

  @override
  State<CVFormView> createState() => _CVFormViewState();
}

class _CVFormViewState extends State<CVFormView> {
  final nameController = TextEditingController(text: "Ahmed Yasser Mohammed");
  final emailController = TextEditingController(text: "AhmedYasser.dev@gmail.com");
  final phoneController = TextEditingController(text: "+201023665622");
  final locationController = TextEditingController(text: "Cairo, Egypt");
  final jobTitleController = TextEditingController(text: "Frontend Developer");
  final companyController = TextEditingController(text: "TechNova Solutions");
  final descriptionController = TextEditingController(
      text:
      "• Built responsive web applications using React and modern JavaScript.\n"
          "• Improved website performance by optimizing components and reducing load time by 35%.\n"
          "• Collaborated with UI/UX designers to implement pixel-perfect designs.\n"
          "• Integrated REST APIs and handled state management efficiently.\n"
          "• Participated in code reviews and followed clean architecture principles."
  );
  final skillsController = TextEditingController(
      text: "React, JavaScript, HTML, CSS, SCSS, Git, REST APIs, Responsive Design, Figma, Firebase");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("CV Template", style: AppFonts.movbold18),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AnimatedNavBar(initialIndex: 3,),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField("Full Name", nameController),
            _buildField("Email", emailController),
            _buildField("Phone", phoneController),
            _buildField("Location", locationController),
            const SizedBox(height: 20),
            const Divider(),
            _buildField("Job Title", jobTitleController),
            _buildField("Company", companyController),
            _buildField("Job Description", descriptionController, maxLines: 4),
            const SizedBox(height: 20),
            const Divider(),
            _buildField("Skills (comma separated)", skillsController, maxLines: 3),
            const SizedBox(height: 30),
            CustomButtom(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CVPreviewView(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      location: locationController.text,
                      jobTitle: jobTitleController.text,
                      company: companyController.text,
                      description: descriptionController.text,
                      skills: skillsController.text,
                    ),
                  ),
                );
              },
              text: "Generate CV",
              color: AppColors.movColor,
              borderColor: AppColors.movColor,
              width: 360,
              height: 60,
              textStyle: AppFonts.whiteSemiBold18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class CVPreviewView extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String jobTitle;
  final String company;
  final String description;
  final String skills;

  final VoidCallback? onEdit;

  const CVPreviewView({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.jobTitle,
    required this.company,
    required this.description,
    required this.skills,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    List<String> skillsList =
    skills.split(",").map((e) => e.trim()).toList();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
       automaticallyImplyLeading: false,
        title: Center(child: Text("CV Preview", style: AppFonts.whiteSemiBold18)),
        backgroundColor: AppColors.movColor,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.whiteColor, size: 30),
            onPressed: onEdit ??
                    () {
                  Navigator.pop(context);
                },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 850,
            margin: const EdgeInsets.symmetric(vertical: 40),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 2,
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 30,
                  runSpacing: 10,
                  children: [
                    _infoItem(Icons.email_outlined, email),
                    _infoItem(Icons.phone_outlined, phone),
                    _infoItem(Icons.location_on_outlined, location),
                  ],
                ),
                const SizedBox(height: 40),
                _sectionTitle("EXPERIENCE"),
                const SizedBox(height: 20),
                Text(
                  jobTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 40),
                _sectionTitle("SKILLS"),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: skillsList
                      .map(
                        (skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 1,
          width: 40,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
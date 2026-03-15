import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';

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
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    jobTitleController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("CV Template", style: AppFonts.movbold18),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: width * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField("Full Name", nameController),
            _buildField("Email", emailController),
            _buildField("Phone", phoneController),
            _buildField("Location", locationController),
            SizedBox(height: width * 0.03),
            Divider(),
            _buildField("Job Title", jobTitleController),
            _buildField("Company", companyController),
            _buildField("Job Description", descriptionController, maxLines: 4),
            SizedBox(height: width * 0.03),
            Divider(),
            _buildField("Skills (comma separated)", skillsController, maxLines: 3),
            SizedBox(height: width * 0.05),
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
              width: width * 0.8,
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
          filled: true,
          fillColor: AppColors.whiteColor,
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toUpperCase(),
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        height: 2,
                        width: width * 0.2,
                        color: Colors.black,
                      ),
                      SizedBox(height: height * 0.02),
                      Wrap(
                        spacing: width * 0.03,
                        runSpacing: height * 0.01,
                        children: [
                          _infoItem(Icons.email_outlined, email),
                          _infoItem(Icons.phone_outlined, phone),
                          _infoItem(Icons.location_on_outlined, location),
                        ],
                      ),
                      SizedBox(height: height * 0.05),
                      _sectionTitle("EXPERIENCE"),
                      SizedBox(height: height * 0.02),
                      Text(
                        jobTitle,
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        company,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      _sectionTitle("SKILLS"),
                      SizedBox(height: height * 0.02),
                      Wrap(
                        spacing: width * 0.02,
                        runSpacing: height * 0.01,
                        children: skillsList
                            .map(
                              (skill) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              );
            },
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6),
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
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
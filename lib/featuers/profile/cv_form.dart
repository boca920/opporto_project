import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vision_gallery_saver/vision_gallery_saver.dart';

class CVFormView extends StatefulWidget {
  const CVFormView({super.key});

  @override
  State<CVFormView> createState() => _CVFormViewState();
}

class _CVFormViewState extends State<CVFormView> {
  final _formKey = GlobalKey<FormState>();

  // Personal
  final nameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final locationController = TextEditingController();

  // ATS Sections
  final summaryController = TextEditingController();
  final expFromController = TextEditingController();
  final expToController = TextEditingController(text: "Present");
  final companyController = TextEditingController();
  final expRoleController = TextEditingController();
  final expBulletsController = TextEditingController(
    text:
    "Successfully connected internal teams with external partners.\n"
        "Improved process efficiency and reduced delays.\n"
        "Analyzed data and presented clear business recommendations.",
  );

  final eduYearController = TextEditingController();
  final eduDegreeController = TextEditingController();
  final eduUniversityController = TextEditingController();

  final certYearController = TextEditingController();
  final certNameController = TextEditingController();

  final skillsController = TextEditingController(
    text: "Analytical Skills - Advanced\nBusiness Intelligence - Advanced\nMarketing - Intermediate",
  );
  final languagesController = TextEditingController(
    text: "English - Native\nArabic - Native",
  );

  @override
  void dispose() {
    nameController.dispose();
    jobTitleController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    locationController.dispose();
    summaryController.dispose();
    expFromController.dispose();
    expToController.dispose();
    companyController.dispose();
    expRoleController.dispose();
    expBulletsController.dispose();
    eduYearController.dispose();
    eduDegreeController.dispose();
    eduUniversityController.dispose();
    certYearController.dispose();
    certNameController.dispose();
    skillsController.dispose();
    languagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("ATS CV Builder", style: AppFonts.movbold18),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AnimatedNavBar(initialIndex: 3),
              ),
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Personal Information"),
              _buildField("Full Name *", nameController, requiredField: true),
              _buildField("Target Job Title *", jobTitleController, requiredField: true),
              _buildField("Email *", emailController,
                  keyboardType: TextInputType.emailAddress, requiredField: true),
              _buildField("Phone *", phoneController,
                  keyboardType: TextInputType.phone, requiredField: true),
              _buildField("Website / Portfolio", websiteController),
              _buildField("Location *", locationController, requiredField: true),

              const SizedBox(height: 8),
              _sectionTitle("Professional Summary"),
              _buildField(
                "Summary *",
                summaryController,
                maxLines: 4,
                requiredField: true,
                hint: "2-4 lines matching the job keywords",
              ),

              const SizedBox(height: 8),
              _sectionTitle("Experience"),
              Row(
                children: [
                  Expanded(child: _buildField("From (MM/YYYY) *", expFromController, requiredField: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildField("To (MM/YYYY or Present) *", expToController, requiredField: true)),
                ],
              ),
              _buildField("Company *", companyController, requiredField: true),
              _buildField("Role / Position *", expRoleController, requiredField: true),
              _buildField(
                "Achievements (one per line) *",
                expBulletsController,
                maxLines: 6,
                requiredField: true,
                hint: "Use strong action verbs + measurable impact",
              ),

              const SizedBox(height: 8),
              _sectionTitle("Education"),
              _buildField("Education Year *", eduYearController, requiredField: true),
              _buildField("Degree *", eduDegreeController, requiredField: true),
              _buildField("University *", eduUniversityController, requiredField: true),

              const SizedBox(height: 8),
              _sectionTitle("Certificates"),
              _buildField("Certificate Year", certYearController),
              _buildField("Certificate Name", certNameController),

              const SizedBox(height: 8),
              _sectionTitle("Skills"),
              _buildField(
                "Skills (each line: Skill - Level) *",
                skillsController,
                maxLines: 5,
                requiredField: true,
                hint: "Example: Flutter - Advanced",
              ),

              const SizedBox(height: 8),
              _sectionTitle("Languages"),
              _buildField(
                "Languages (each line: Language - Level) *",
                languagesController,
                maxLines: 4,
                requiredField: true,
                hint: "Example: English - Native",
              ),

              SizedBox(height: width * 0.05),
              CustomButtom(
                onTap: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CVPreviewView(
                        name: nameController.text.trim(),
                        targetTitle: jobTitleController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),
                        website: websiteController.text.trim(),
                        location: locationController.text.trim(),
                        summary: summaryController.text.trim(),
                        expFrom: expFromController.text.trim(),
                        expTo: expToController.text.trim(),
                        expRole: expRoleController.text.trim(),
                        company: companyController.text.trim(),
                        expBullets: expBulletsController.text.trim(),
                        eduYear: eduYearController.text.trim(),
                        eduDegree: eduDegreeController.text.trim(),
                        eduUniversity: eduUniversityController.text.trim(),
                        certYear: certYearController.text.trim(),
                        certName: certNameController.text.trim(),
                        skills: skillsController.text.trim(),
                        languages: languagesController.text.trim(),
                      ),
                    ),
                  );
                },
                text: "Generate ATS CV",
                color: AppColors.movColor,
                borderColor: AppColors.movColor,
                width: width * 0.8,
                height: 56,
                textStyle: AppFonts.whiteSemiBold18,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        title,
        style: AppFonts.blackbold16.copyWith(fontSize: 17),
      ),
    );
  }

  Widget _buildField(
      String label,
      TextEditingController controller, {
        int maxLines = 1,
        bool requiredField = false,
        TextInputType keyboardType = TextInputType.text,
        String? hint,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (!requiredField) return null;
          if ((value ?? '').trim().isEmpty) return "Required field";
          if (label.toLowerCase().contains("email")) {
            final ok = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!.trim());
            if (!ok) return "Invalid email";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class CVPreviewView extends StatefulWidget {
  final String name;
  final String targetTitle;
  final String email;
  final String phone;
  final String website;
  final String location;
  final String summary;

  final String expFrom;
  final String expTo;
  final String expRole;
  final String company;
  final String expBullets;

  final String eduYear;
  final String eduDegree;
  final String eduUniversity;

  final String certYear;
  final String certName;

  final String skills;
  final String languages;

  const CVPreviewView({
    super.key,
    required this.name,
    required this.targetTitle,
    required this.email,
    required this.phone,
    required this.website,
    required this.location,
    required this.summary,
    required this.expFrom,
    required this.expTo,
    required this.expRole,
    required this.company,
    required this.expBullets,
    required this.eduYear,
    required this.eduDegree,
    required this.eduUniversity,
    required this.certYear,
    required this.certName,
    required this.skills,
    required this.languages,
  });

  @override
  State<CVPreviewView> createState() => _CVPreviewViewState();
}

class _CVPreviewViewState extends State<CVPreviewView> {
  final GlobalKey _cvCaptureKey = GlobalKey();
  bool _isSaving = false;

  Future<bool> _requestGalleryPermission() async {
    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      return true;
    }

    final photos = await Permission.photos.request();
    if (photos.isGranted) return true;

    final storage = await Permission.storage.request();
    if (storage.isGranted) return true;

    return false;
  }

  Future<void> _saveCvAsImage() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final allowed = await _requestGalleryPermission();
      if (!allowed) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Permission denied. Please allow gallery/storage permission."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final boundary = _cvCaptureKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      // Higher pixel ratio for better clarity in gallery
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final result = await VisionGallerySaver.saveImage(
        pngBytes,
        quality: 100,
        name: "ATS_CV_${DateTime.now().millisecondsSinceEpoch}",
      );

      final isSuccess = (result['isSuccess'] == true) || (result['filePath'] != null);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isSuccess ? "CV image saved to gallery successfully" : "Failed to save CV"),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error while saving CV image"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  List<String> _splitLines(String input) {
    return input
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final skillsList = _splitLines(widget.skills);
    final languagesList = _splitLines(widget.languages);
    final bullets = _splitLines(widget.expBullets);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Center(child: Text("ATS CV Preview", style: AppFonts.whiteSemiBold18)),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.movColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: RepaintBoundary(
                  key: _cvCaptureKey,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header like ATS style
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.targetTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _smallInfo(widget.phone),
                                _smallInfo(widget.email),
                                if (widget.website.isNotEmpty) _smallInfo(widget.website),
                                _smallInfo(widget.location),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),

                        if (widget.summary.isNotEmpty) ...[
                          _sectionLineTitle("PROFESSIONAL SUMMARY"),
                          const SizedBox(height: 10),
                          Text(
                            widget.summary,
                            style: const TextStyle(fontSize: 13.5, height: 1.55),
                          ),
                          const SizedBox(height: 18),
                        ],

                        _sectionLineTitle("EXPERIENCE"),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 95,
                              child: Text(
                                "${widget.expFrom} - ${widget.expTo}",
                                style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.expRole,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.company,
                                    style: const TextStyle(fontSize: 13.2, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 8),
                                  ...bullets.map(
                                        (b) => Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text("• $b",
                                          style: const TextStyle(fontSize: 13.2, height: 1.45)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        _sectionLineTitle("EDUCATION"),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 95,
                              child: Text(
                                widget.eduYear,
                                style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "${widget.eduDegree}\n${widget.eduUniversity}",
                                style: const TextStyle(fontSize: 13.2, height: 1.45),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        if (widget.certName.isNotEmpty) ...[
                          _sectionLineTitle("CERTIFICATES"),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: 95,
                                child: Text(
                                  widget.certYear,
                                  style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.certName,
                                  style: const TextStyle(fontSize: 13.2, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                        ],

                        _sectionLineTitle("SKILLS"),
                        const SizedBox(height: 10),
                        _twoColumnItems(skillsList),
                        const SizedBox(height: 18),

                        _sectionLineTitle("LANGUAGES"),
                        const SizedBox(height: 10),
                        _twoColumnItems(languagesList),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSaving ? null : _saveCvAsImage,
                      icon: _isSaving
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Icon(Icons.save_alt),
                      label: Text(_isSaving ? "Saving..." : "Save as Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.movColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(52),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.5, color: Colors.black87),
      ),
    );
  }

  Widget _sectionLineTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 6),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF4EC6C1), width: 1.2),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.4,
          color: Color(0xFF222222),
        ),
      ),
    );
  }

  Widget _twoColumnItems(List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    final left = <String>[];
    final right = <String>[];

    for (int i = 0; i < items.length; i++) {
      if (i.isEven) {
        left.add(items[i]);
      } else {
        right.add(items[i]);
      }
    }

    Widget column(List<String> data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data
            .map(
              (e) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              e,
              style: const TextStyle(fontSize: 13.2, color: Colors.black87),
            ),
          ),
        )
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: column(left)),
        const SizedBox(width: 16),
        Expanded(child: column(right)),
      ],
    );
  }
}
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class EditProfileView extends StatefulWidget {
  final String fullName;
  final String email; // موجود للعرض فقط (بدون تعديل)
  final String phone;
  final String address;

  // اختياري: لو عندك صورة/سي في محفوظين قبل كده
  final String? profileImagePath;
  final String? cvPath;

  const EditProfileView({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.profileImagePath,
    this.cvPath,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  String? _profileImagePath;
  String? _cvPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _profileImagePath = widget.profileImagePath;
    _cvPath = widget.cvPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    setState(() {
      _profileImagePath = picked.path;
    });
  }

  void _removeProfileImage() {
    setState(() {
      _profileImagePath = null;
    });
  }

  Future<void> _pickCv() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result == null || result.files.isEmpty) return;

    setState(() {
      _cvPath = result.files.single.path;
    });
  }

  void _removeCv() {
    setState(() {
      _cvPath = null;
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop<Map<String, String?>>(context, {
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
      'profileImagePath': _profileImagePath,
      'cvPath': _cvPath,
    });
  }

  @override
  Widget build(BuildContext context) {
    final cvName = (_cvPath == null || _cvPath!.isEmpty)
        ? null
        : _cvPath!.split(Platform.pathSeparator).last;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Update Profile', style: AppFonts.blackbold18),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: (_profileImagePath != null &&
                          _profileImagePath!.isNotEmpty)
                          ? FileImage(File(_profileImagePath!))
                          : null,
                      child: (_profileImagePath == null || _profileImagePath!.isEmpty)
                          ? const Icon(Icons.person, size: 44, color: Colors.grey)
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickProfileImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.movColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (_profileImagePath != null && _profileImagePath!.isNotEmpty)
              TextButton.icon(
                onPressed: _removeProfileImage,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Remove Profile Image',
                  style: TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 8),
            _buildLabel('Full Name'),
            _buildField(
              controller: _nameController,
              hint: 'Enter full name',
              validator: (v) {
                final value = (v ?? '').trim();
                if (value.isEmpty) return 'Full name is required';
                if (value.length < 3) return 'At least 3 characters';
                return null;
              },
            ),

            const SizedBox(height: 12),
            _buildLabel('Email (Read only)'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                widget.email,
                style: AppFonts.blackbold16.copyWith(color: Colors.black87),
              ),
            ),

            const SizedBox(height: 12),
            _buildLabel('Phone'),
            _buildField(
              controller: _phoneController,
              hint: '+201000000000',
              keyboardType: TextInputType.phone,
              validator: (v) {
                final value = (v ?? '').trim().replaceAll(' ', '');
                if (value.isEmpty) return 'Phone is required';
                if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),
            _buildLabel('Address'),
            _buildField(
              controller: _addressController,
              hint: 'Enter address',
              maxLines: 2,
              validator: (v) {
                if ((v ?? '').trim().isEmpty) return 'Address is required';
                return null;
              },
            ),

            const SizedBox(height: 16),
            _buildLabel('CV'),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cvName != null)
                    Text(
                      cvName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.blackbold16.copyWith(fontSize: 14),
                    )
                  else
                    Text(
                      'No CV selected',
                      style: AppFonts.blackbold16.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickCv,
                          icon: const Icon(Icons.upload_file),
                          label: Text(cvName == null ? 'Add CV' : 'Replace CV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.movColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      if (cvName != null) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _removeCv,
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            label: const Text(
                              'Remove CV',
                              style: TextStyle(color: Colors.red),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.movColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: AppFonts.blackbold16),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.movColor, width: 1.4),
        ),
      ),
    );
  }
}
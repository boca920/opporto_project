import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePickerService _pickerService = ImagePickerService();
  File? _selectedImage;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController industryController;
  late TextEditingController aboutController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final user = context.read<JobBloc>().state.userModel;
    nameController = TextEditingController(text: user?.name ?? "");
    phoneController = TextEditingController(text: user?.phone ?? "");
    industryController = TextEditingController(text: user?.industry ?? "Software Development");
    aboutController = TextEditingController(text: user?.about ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    industryController.dispose();
    aboutController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBloc, JobState>(
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
                content: Text("Profile Updated Successfully!")),
          );
          Navigator.pop(context, true);
        } else if (state.status == RequestStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.message ?? "Update Failed")),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Edit Company Profile",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _pickerService.showImageSourceDialog(context, (file) {
                          setState(() {
                            _selectedImage = file;
                          });
                        });
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : const AssetImage('assets/images/logo1.png') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF3730A3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildLabel("Company Name"),
                  _buildTextField(
                    controller: nameController,
                    hint: "Enter company name",
                    icon: Icons.business_outlined,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Industry"),
                  _buildTextField(
                    controller: industryController,
                    hint: "e.g. Technology",
                    icon: Icons.category_outlined,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Phone Number"),
                  _buildTextField(
                    controller: phoneController,
                    hint: "Enter phone number",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("About Company"),
                  _buildTextField(
                    controller: aboutController,
                    hint: "Describe your company...",
                    icon: Icons.info_outline,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: state.status == RequestStatus.loading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<JobBloc>().add(
                            UpdateProfileEvent(
                              token: context.read<UserProvider>().token ?? "",
                              name: nameController.text,
                              phone: phoneController.text,
                              about: aboutController.text,
                              industry: industryController.text,
                              imageFile: _selectedImage,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3730A3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: state.status == RequestStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: enabled,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF818181), fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFF3730A3), size: 20),
        filled: true,
        fillColor: enabled ? const Color(0xFFF9FAFB) : const Color(0xFFF3F4F6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
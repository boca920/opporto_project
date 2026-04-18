import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_bloc.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_event.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_state.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';

class ApplyBottomSheet extends StatefulWidget {
  final dynamic job;
  const ApplyBottomSheet({super.key, required this.job});

  @override
  State<ApplyBottomSheet> createState() => _ApplyBottomSheetState();
}

class _ApplyBottomSheetState extends State<ApplyBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _coverLetterController = TextEditingController();

  File? _selectedFile;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  // اختيار ملف
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<ApplicationBloc, ApplicationState>(
          listener: (context, state) async {
            if (state.status == RequestStatus.success) {
              // اقفل الأول وارجع success
              Navigator.pop(context, true);
            } else if (state.status == RequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? "حدث خطأ"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                controller: controller,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Container(width: 40, height: 4, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Apply for ${widget.job['title']}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person,
                  ),

                  _buildTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  _buildTextField(
                    controller: _phoneController,
                    label: "Phone",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),

                  _buildTextField(
                    controller: _addressController,
                    label: "Address",
                    icon: Icons.location_on,
                  ),

                  _buildTextField(
                    controller: _coverLetterController,
                    label: "Cover Letter",
                    icon: Icons.description,
                    maxLines: 4,
                  ),

                  const SizedBox(height: 10),

                  _buildUploadSection(),

                  const SizedBox(height: 30),

                  _buildSubmitButton(context, state),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Resume (PDF)",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedFile != null ? Colors.green : Colors.blue,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.upload_file,
                    color: _selectedFile != null ? Colors.green : Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedFile == null
                        ? "Upload Resume"
                        : _selectedFile!.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, ApplicationState state) {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).token ?? "";

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: state.status == RequestStatus.loading
            ? null
            : () {
          if (!_formKey.currentState!.validate()) return;

          if (_selectedFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please upload resume")),
            );
            return;
          }

          context.read<ApplicationBloc>().add(
            SubmitApplicationEvent(
              jobId: widget.job['_id'].toString(),
              resume: _selectedFile!,
              token: userToken,
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              phone: _phoneController.text.trim(),
              address: _addressController.text.trim(),
              coverLetter: _coverLetterController.text.trim(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F2038),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: state.status == RequestStatus.loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          "Submit Application",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
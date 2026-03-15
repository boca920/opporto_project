import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opporto_project/featuers/profile/profile_view.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/drop_down_button.dart';
import 'package:opporto_project/core/services/auth_service.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // ✅ Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ Form & Focus
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // ✅ State
  bool isLoading = false;
  String? selectedRole;
  final List<String> roles = ['Job Seeker', 'Employer'];

  @override
  void initState() {
    super.initState();
    _loadSavedRole();
  }

  // ✅ Save role for email
  Future<void> _saveRoleForEmail(String email, String role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('role_$email', role);
      print('✅ Role saved for $email: $role');
    } catch (e) {
      print('❌ Error saving role: $e');
    }
  }

  // ✅ Load saved role for email
  Future<void> _loadSavedRole() async {
    final email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final savedRole = prefs.getString('role_$email');
        if (savedRole != null && roles.contains(savedRole)) {
          if (mounted) {
            setState(() {
              selectedRole = savedRole;
            });
            print('✅ Loaded saved role for $email: $savedRole');
          }
        }
      } catch (e) {
        print('❌ Error loading role: $e');
      }
    }
  }

  // ✅ Check saved role when typing email
  void _checkSavedRole(String email) {
    if (email.isNotEmpty) {
      _loadSavedRole();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ✅ Debug function
  void _debugPrintFormState() {
    print('=== DEBUG FORM STATE ===');
    print('Form valid: ${_formKey.currentState?.validate() ?? false}');
    print('Name: "${nameController.text}"');
    print('Email: "${emailController.text}"');
    print('Phone: "${phoneController.text}"');
    print('Password: "${passwordController.text.length} chars"');
    print('Role: $selectedRole');
    print('=======================');
  }

  Future<void> _handleRegister() async {
    print('🔥 REGISTER BUTTON PRESSED');

    setState(() => isLoading = true);

    try {
      final email = emailController.text.trim();

      // ✅ Save role before sending request
      if (selectedRole != null) {
        await _saveRoleForEmail(email, selectedRole!);
      }

      // ✅ Call API
      print('📡 Calling AuthService.register...');
      final result = await AuthService.register(
        name: nameController.text.trim(),
        email: email,
        phone: phoneController.text.trim(),
        password: passwordController.text,
        role: selectedRole!,
      );

      print('✅ API Response: $result');

      if (result['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final responseData = result['data'];

        await userProvider.setUser(responseData['user'], responseData['token']);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration Successful'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileView(
                fullName: responseData['user']['name'] ?? '',
                address: responseData['user']['address'] ?? '',
                phone: responseData['user']['phone'] ?? '',
                email: responseData['user']['email'] ?? '',
              ),
            ),
          );
        }
      } else {
        _showError(result['message'] ?? 'Registration Failed');
      }
    } catch (e) {
      print('❌ Error: $e');
      _showError('Error: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.movColor),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Onboarding3()),
          ),
        ),
        title: const Text(
          'Create New Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                // ✅ Test Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 80,
                    color: AppColors.movColor,
                  ),
                ),
                SizedBox(height: height * 0.04),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Role Dropdown
                      const Text(
                        "Select Your Role",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: selectedRole != null
                              ? Border.all(color: AppColors.movColor, width: 2)
                              : Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          color: selectedRole != null ? AppColors.movColor.withOpacity(0.05) : null,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: CustomDropDownButton(
                            hint: selectedRole != null ? selectedRole! : 'Select Your Role',
                            value: selectedRole,
                            items: roles
                                .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRole = value;
                              });
                              print('Role selected: $value');
                            },
                          ),
                        ),
                      ),
                      if (selectedRole == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 16),
                          child: Text(
                            'Please select a role',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: height * 0.02),

                      // ✅ Email Field
                      const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      TextFormField(
                        controller: emailController,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _phoneFocus.requestFocus(),
                        decoration: InputDecoration(
                          hintText: "example@email.com",
                          prefixIcon: Icon(CupertinoIcons.mail, color: AppColors.movColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.movColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                        ),
                        style: const TextStyle(fontSize: 16),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Email is required *';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.trim().isNotEmpty) {
                            Future.delayed(const Duration(milliseconds: 500), () {
                              if (emailController.text.trim() == value.trim() && mounted) {
                                _checkSavedRole(value.trim());
                              }
                            });
                          }
                        },
                      ),
                      SizedBox(height: height * 0.015),

                      // ✅ Name Field
                      const Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      CustomTextFormField(
                        controller: nameController,
                        focusNode: _nameFocus,
                        hintText: "Enter Your Name",
                        prefixIconData: CupertinoIcons.person,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Name is required *';
                          if (value.trim().length < 3) return 'Name must be at least 3 characters';
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                      ),
                      SizedBox(height: height * 0.015),

                      // ✅ Phone Field
                      const Text("Phone Number", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      CustomTextFormField(
                        controller: phoneController,
                        focusNode: _phoneFocus,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter your phone number (numbers only)",
                        prefixIconData: CupertinoIcons.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Phone number is required *';
                          if (!RegExp(r'^[0-9]{6,}$').hasMatch(value.trim().replaceAll(' ', ''))) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
                      ),
                      SizedBox(height: height * 0.015),

                      // ✅ Password Field
                      const Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      CustomTextFormField(
                        controller: passwordController,
                        focusNode: _passwordFocus,
                        hintText: "Password must be at least 6 characters",
                        prefixIconData: CupertinoIcons.padlock_solid,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Password is required *';
                          if (value.length < 6) return 'Password must be at least 6 characters';
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: height * 0.04),

                      // ✅ REGISTER BUTTON
                      SizedBox(
                        width: width * 0.92,
                        height: height * 0.07,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () {
                            print('🚀 Button Pressed');
                            _debugPrintFormState();

                            if (_formKey.currentState!.validate() && selectedRole != null) {
                              print('✅ All fields are valid - Calling register...');
                              _handleRegister();
                            } else {
                              print('❌ Validation Failed');
                              _showError('✅ Please fill in all fields correctly');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.movColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                          ),
                          child: isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                              : const Text(
                            "Create Account Now",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.08),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ✅ Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.movColor),
              ),
            ),
        ],
      ),
    );
  }
}
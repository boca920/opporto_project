import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';
import 'package:opporto_project/featuers/register/register_view.dart';
import 'package:opporto_project/core/services/auth_service.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import '../../core/ui/onboarding3.dart';
import 'forget_password.dart';
import 'dart:async';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form Key & Focus Nodes
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();


  bool isLoading = false;
  String? savedRole;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSavedRole(String email) async {
    if (email.trim().isEmpty) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final role = prefs.getString('role_${email.trim().toLowerCase()}');
        if (role != null && mounted) {
          setState(() {
            savedRole = role;
          });
          print(' LoginView - Loaded role for $email: $role');
        }
      } catch (e) {
        print(' Error loading role: $e');
      }
    });
  }


  Future<void> _handleLogin() async {
    print(' LOGIN BUTTON PRESSED');

    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      _showError('Please fill in all fields correctly');
      return;
    }

    setState(() => isLoading = true);

    try {
      final email = emailController.text.trim();

      final roleToUse = savedRole ?? null;
      print(' Login role filter: $roleToUse');

      final result = await AuthService.login(
        email: email,
        password: passwordController.text,
        role: roleToUse,
      );

      print(' Login Response: $result');

      if (result['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final responseData = result['data'];


        final user = responseData['user'];
        print('👤 Logged in as: ${user['role']} - ${user['name']}');

        await userProvider.setUser(user, responseData['token']);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Welcome back ${user['name'] ?? ''}! 🎉\nRole: ${user['role']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );


          final userRole = user['role'] ?? 'Job Seeker';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AnimatedNavBar(
                initialIndex: userRole == 'Employer' ? 2 : 0,
              ),
            ),
          );
        }
      } else {
        _showError(result['message'] ?? 'Login Failed');
      }
    } catch (e) {
      print('Login Error: $e');
      _showError('Connection Error: ${e.toString()}');
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
        title: const Text(
          'Welcome Back',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.movColor),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Onboarding3()),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.03),

                Image.asset(
                  AppAssets.login,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: height * 0.3,
                ),
                SizedBox(height: height * 0.04),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      TextFormField(
                        controller: emailController,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
                        decoration: InputDecoration(
                          hintText: "Enter your email",
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
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Email is required *';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) => _loadSavedRole(value),
                      ),


                      if (savedRole != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.movColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: AppColors.movColor, width: 1.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  savedRole == 'Job Seeker' ? Icons.work : Icons.business_center,
                                  color: AppColors.movColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Role: $savedRole',
                                  style: TextStyle(
                                    color: AppColors.movColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      SizedBox(height: height * 0.03),
                      const Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      CustomTextFormField(
                        controller: passwordController,
                        focusNode: _passwordFocus,
                        hintText: "Enter your password",
                        prefixIconData: CupertinoIcons.padlock_solid,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Password is required *';
                          if (value.length < 6) return 'Password must be at least 6 characters';
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                      ),


                      SizedBox(height: height * 0.015),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgetPassword()),
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.05),


                      CustomButtom(
                        text: isLoading ? "Signing In..." : "Sign In",
                        color: isLoading ? Colors.grey : AppColors.movColor,
                        borderColor: isLoading ? Colors.grey : AppColors.movColor,
                        width: width * 0.95,
                        height: height * 0.07,
                        textStyle: AppFonts.whiteSemiBold18,
                        onTap: isLoading ? null : _handleLogin,
                      ),

                      SizedBox(height: height * 0.03),


                      CustomButtom(
                        text: "Create New Account",
                        color: AppColors.transparent,
                        borderColor: AppColors.movColor,
                        width: width * 0.95,
                        height: height * 0.07,
                        textStyle: AppFonts.movbold18,
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterView()),
                        ),
                      ),

                      SizedBox(height: height * 0.08),
                    ],
                  ),
                ),
              ],
            ),
          ),


          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.movColor),
                    SizedBox(height: 16),
                    Text('Signing you in...', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
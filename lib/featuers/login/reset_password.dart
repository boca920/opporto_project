import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/services/auth_service.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/featuers/login/login_view.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPassword({super.key, required this.email, required this.otp});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    print('🔥 RESET BUTTON PRESSED');

    if (!_formKey.currentState!.validate()) {
      print('❌ Form validation failed');
      return;
    }

    final password = passwordController.text.trim();
    final confirmPassword = rePasswordController.text.trim();

    print('🔍 DEBUG INFO:');
    print('Email: "${widget.email}"');
    print('OTP: "${widget.otp}" (length: ${widget.otp.length})');
    print('Password: "$password" (length: ${password.length})');
    print('Confirm: "$confirmPassword"');

    if (password != confirmPassword) {
      _showError('كلمات المرور غير متطابقة');
      return;
    }

    if (password.length < 8) {
      _showError('كلمة المرور يجب أن تكون 8 أحرف على الأقل');
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await AuthService.resetPasswordOtp(
        email: widget.email,
        otp: widget.otp,
        password: password,
        confirmPassword: confirmPassword,
      );

      print(' API RESULT: $result');

      if (result['success']) {
        _showSuccessDialog();
      } else {
        _showError(result['message'] ?? 'فشل إعادة تعيين كلمة المرور');
      }
    } catch (e) {
      print(' CATCH ERROR: $e');
      _showError('خطأ في الاتصال: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: SizedBox(
            height: height * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: height * 0.02),
                Text('Success !', style: AppFonts.blackbold40),
                SizedBox(height: height * 0.015),
                Text(
                  "Your password has been changed successfully!\nYou can now login with your new password.",
                  textAlign: TextAlign.center,
                  style: AppFonts.blackbold16,
                ),
                SizedBox(height: height * 0.025),
                Image.asset(AppAssets.suc, width: 120, height: 120),
                SizedBox(height: height * 0.03),
                CustomButtom(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginView()),
                          (route) => false,
                    );
                  },
                  text: "Back to Login",
                  color: AppColors.movColor,
                  borderColor: AppColors.movColor,
                  width: double.infinity,
                  height: height * 0.065,
                  textStyle: AppFonts.whitemedium16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.12),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.blackColor, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reset your password", style: AppFonts.blackmeduim24),
                  SizedBox(height: height * 0.015),
                  Text(
                    "Enter your new password for ${widget.email.split('@')[0]}",
                    style: AppFonts.graybold14,
                  ),
                  SizedBox(height: height * 0.04),

                  Text("New Password", style: AppFonts.blackbold14),
                  SizedBox(height: height * 0.015),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Enter new password (min 8 characters)",
                    prefixIconData: CupertinoIcons.padlock_solid,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'كلمة المرور مطلوبة';
                      }
                      if (value.trim().length < 8) {
                        return 'يجب أن تكون 8 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.045),
                  Text("Confirm New Password", style: AppFonts.blackbold14),
                  SizedBox(height: height * 0.015),
                  CustomTextFormField(
                    controller: rePasswordController,
                    hintText: "Re-enter new password",
                    prefixIconData: CupertinoIcons.padlock_solid,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'تأكيد كلمة المرور مطلوب';
                      }
                      if (value.trim() != passwordController.text.trim()) {
                        return 'كلمات المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.06),
                  CustomButtom(
                    onTap: isLoading ? null : _handleResetPassword,
                    text: isLoading ? 'جاري التحديث...' : "Reset Password",
                    color: isLoading ? Colors.grey : AppColors.movColor,
                    borderColor: isLoading ? Colors.grey : AppColors.movColor,
                    width: double.infinity,
                    height: height * 0.07,
                    textStyle: AppFonts.whitemedium16,
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),

          // Loading Overlay
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
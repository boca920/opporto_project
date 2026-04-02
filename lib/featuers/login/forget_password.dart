import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/otp/otp_view.dart';
import 'package:opporto_project/core/services/auth_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _handleSendOtp() async {
    if (emailController.text.trim().isEmpty) {
      _showError('الرجاء إدخال الإيميل');
      return;
    }

    setState(() => isLoading = true);

    try {
      print('📤 Sending OTP to: ${emailController.text}');
      final result = await AuthService.forgotPassword(
        email: emailController.text.trim(),
      );

      print('✅ Forgot Password Result: $result');

      if (result['success']) {
        // ✅ ابحث عن الـ token في الـ response بكل الطرق
        String? token;
        final data = result['data'];

        if (data is Map) {
          token = data['token'] ??
              data['resetToken'] ??
              data['sessionToken'] ??
              data['otpToken'];
        } else if (result['token'] != null) {
          token = result['token'];
        }

        print('🔑 Token found: ${token != null ? token.substring(0, 20) + '...' : 'NULL'}');

        if (token != null && token.isNotEmpty) {
          // ✅ نجح! مرر الـ token للـ OtpView
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✅ تم إرسال الكود إلى ${emailController.text}'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpView(
                email: emailController.text.trim(),
                otpToken: token!,
              ),
            ),
          );
        } else {
          // 🚫 حل مؤقت: استخدم الإيميل كـ token
          print('⚠️ No token found, using email as fallback');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✅ تم إرسال الكود، تحقق من بريدك الإلكتروني'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpView(
                email: emailController.text.trim(),
                otpToken: emailController.text.trim(),
              ),
            ),
          );
        }
      } else {
        _showError(result['message'] ?? 'فشل إرسال الكود');
      }
    } catch (e) {
      print('❌ Error: $e');
      _showError('خطأ في الاتصال: ${e.toString()}');
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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.blackColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot password?",
                  style: AppFonts.blackmeduim24,
                ),
                SizedBox(height: height * 0.015),
                Text(
                  "Don't worry! It happens. Please enter the email\nassociated with your account.",
                  style: AppFonts.graybold14,
                ),
                SizedBox(height: height * 0.02),
                Text("Email", style: AppFonts.blackbold14),
                SizedBox(height: height * 0.015),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Enter your email address",
                  hintTextStyle: AppFonts.graybold14,
                  prefixIconData: CupertinoIcons.mail,
                  isActive: false,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'الإيميل مطلوب';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value.trim())) {
                      return 'الرجاء إدخال إيميل صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.025),
                CustomButtom(
                  onTap: isLoading ? null : _handleSendOtp,
                  text: isLoading ? "جاري الإرسال..." : "Send code",
                  color: isLoading ? Colors.grey : AppColors.movColor,
                  borderColor: isLoading ? Colors.grey : AppColors.movColor,
                  width: double.infinity,
                  height: height * 0.06,
                  textStyle: AppFonts.whitemedium16,
                ),
              ],
            ),
          ),
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
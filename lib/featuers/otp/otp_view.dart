import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/services/auth_service.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/featuers/login/forget_password.dart';
import 'package:opporto_project/featuers/login/reset_password.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import 'otp_input.dart';

class OtpView extends StatefulWidget {
  final String email;
  final String otpToken;

  const OtpView({super.key, required this.email, required this.otpToken});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int secondsRemaining = 59;
  Timer? timer;
  bool canResend = false;
  final TextEditingController otpController = TextEditingController();
  bool isVerifying = false;
  bool isLoading = false;
  String? errorMessage;
  late String _otpToken;

  @override
  void initState() {
    super.initState();
    _otpToken = widget.otpToken;
    startTimer();
  }

  void startTimer() {
    secondsRemaining = 59;
    canResend = false;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        setState(() => canResend = true);
        timer.cancel();
      } else {
        setState(() => secondsRemaining--);
      }
    });
  }

  Future<void> _handleResendOtp() async {
    if (isLoading || isVerifying) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await AuthService.forgotPassword(email: widget.email);
      if (result['success']) {
        final data = result['data'];
        String? token;
        if (data is Map) {
          token = data['token'] ??
              data['resetToken'] ??
              data['sessionToken'] ??
              data['otpToken'];
        } else if (result['token'] != null) {
          token = result['token'];
        }
        if (token != null && token.isNotEmpty) {
          _otpToken = token;
        }
        startTimer();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ تم إرسال كود جديد إلى ${widget.email}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ ${result['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('❌ Resend Error: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _handleVerifyOtp() async {
    if (isVerifying || isLoading) return;

    final otp = otpController.text.trim();
    if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('أدخل كود صحيح مكون من 6 أرقام'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      isVerifying = true;
      errorMessage = null;
    });

    try {
      // In this app flow, the OTP is validated by the backend when the user
      // submits the new password (reset-password with OTP). So we just pass it along.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassword(
              email: widget.email,
              otp: otp,
            ),
          ),
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ خطأ في الاتصال'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => isVerifying = false);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.10),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.blackColor, size: 30),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPassword()),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.015),
                Text("Check your Email", style: AppFonts.blackmeduim24),
                const SizedBox(height: 8),
                Text(
                  "We've sent the code to:\n${widget.email}",
                  style: AppFonts.grayRegular14,
                ),
                SizedBox(height: height * 0.04),

                Center(
                  child: Column(
                    children: [
                      OtpInput(
                        controller: otpController,
                        errorText: errorMessage,
                        onCompleted: (pin) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (mounted && !isVerifying && !isLoading) {
                              _handleVerifyOtp();
                            }
                          });
                        },
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "00:${secondsRemaining.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: AppColors.darkGrayColor),
                    ),
                    GestureDetector(
                      onTap: (canResend && !isLoading && !isVerifying)
                          ? _handleResendOtp
                          : null,
                      child: Text(
                        isLoading ? 'جاري الإرسال...' : 'Send code again',
                        style: AppFonts.greymeduim16.copyWith(
                          color: (canResend && !isLoading && !isVerifying)
                              ? AppColors.movColor
                              : Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),

                CustomButtom(
                  text: isVerifying
                      ? 'جاري التحقق...'
                      : otpController.text.length == 6
                      ? 'التحقق من الكود'
                      : 'أدخل الكود أولاً',
                  color: (isVerifying || isLoading || otpController.text.length != 6)
                      ? Colors.grey
                      : AppColors.movColor,
                  borderColor: (isVerifying || isLoading || otpController.text.length != 6)
                      ? Colors.grey
                      : AppColors.movColor,
                  width: double.infinity,
                  height: height * 0.060,
                  textStyle: AppFonts.whitemedium16,
                  onTap: (isVerifying || isLoading || otpController.text.length != 6)
                      ? null
                      : _handleVerifyOtp,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          if (isVerifying || isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.movColor),
                    SizedBox(height: 16),
                    Text(
                      'جاري التحقق من الكود...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
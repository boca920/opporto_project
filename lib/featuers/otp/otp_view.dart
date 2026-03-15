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

  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int secondsRemaining = 59;
  Timer? timer;
  bool canResend = false;
  final TextEditingController otpController = TextEditingController();
  bool isVerifying = false;
  String? enteredOtp; // ✅ حفظ OTP

  @override
  void initState() {
    super.initState();
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
    startTimer();
    final result = await AuthService.forgotPassword(email: widget.email);
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال كود جديد'), backgroundColor: Colors.green),
      );
    }
  }

  Future<void> _handleVerifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل كود التحقق كاملاً (6 أرقام)'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => isVerifying = true);

    try {
      enteredOtp = otp; // ✅ حفظ OTP
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(
            email: widget.email,
            otp: otp, // ✅ تمرير OTP
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isVerifying = false);
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
    var width = MediaQuery.of(context).size.width;

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
                  MaterialPageRoute(builder: (context) => ForgetPassword()),
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
                  "We’ve sent the code to:\n${widget.email}",
                  style: AppFonts.grayRegular14,
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: Column(
                    children: [
                      OtpInput(
                        onCompleted: (pin) {
                          otpController.text = pin;
                          print("✅ OTP Completed: $pin");
                        },
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        otpController.text.length == 6 ? 'كود صحيح ✅' : 'أدخل الكود كاملاً',
                        style: TextStyle(
                          color: otpController.text.length == 6 ? Colors.green : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
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
                      onTap: canResend ? _handleResendOtp : null,
                      child: Text(
                        "Send code again",
                        style: AppFonts.greymeduim16.copyWith(
                          color: canResend ? Colors.black : Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                CustomButtom(
                  text: isVerifying ? 'جاري الانتقال...' : 'Verify',
                  color: isVerifying ? Colors.grey : AppColors.movColor,
                  borderColor: isVerifying ? Colors.grey : AppColors.movColor,
                  width: double.infinity,
                  height: height * 0.060,
                  textStyle: AppFonts.whitemedium16,
                  onTap: isVerifying ? null : _handleVerifyOtp,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          if (isVerifying)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator(color: AppColors.movColor)),
            ),
        ],
      ),
    );
  }
}
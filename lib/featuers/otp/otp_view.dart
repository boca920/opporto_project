import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/featuers/login/forget_password.dart';
import 'package:opporto_project/featuers/login/reset_password.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import 'otp_input.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int secondsRemaining = 59;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    secondsRemaining = 59;
    canResend = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.blackColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPassword()),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.015),

            Text("Check your Email", style: AppFonts.blackmeduim24),

            const SizedBox(height: 8),

            Text(
              "We’ve sent the code to your email",
              style: AppFonts.grayRegular14,
            ),

            SizedBox(height: height * 0.04),

            Center(
              child: OtpInput(
                onCompleted: (pin) {
                  debugPrint("Entered OTP: $pin");
                },
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
                  onTap: canResend
                      ? () {
                          startTimer();
                        }
                      : null,
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
              text: 'Verify',
              color: AppColors.movColor,
              borderColor: AppColors.movColor,
              width: width * 370,
              height: height * 0.060,
              textStyle: AppFonts.whitemedium16,
              onTap: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ResetPassword()));},
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

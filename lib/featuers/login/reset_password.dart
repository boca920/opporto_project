import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/featuers/login/forget_password.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/widget/Custom_text_form_field.dart';
import '../../core/widget/custom_buttom.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    
    TextEditingController rePasswordController=TextEditingController();

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
                      builder: (context) => const ForgetPassword(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reset password",
              style: AppFonts.blackmeduim24,
            ),
            SizedBox(height: height * 0.015),
            Text(
              "Please type something you’ll remember.",
              style: AppFonts.graybold14,
            ),
            SizedBox(height: height * 0.02),
            Text("New Password", style: AppFonts.blackbold14),
            SizedBox(height: height * 0.015),
            CustomTextFormField(
              hintText: "Enter your password",
              prefixIconData: CupertinoIcons.padlock,
              isActive: false, isPassword:true, controller: passwordController,
            ),
            SizedBox(height: height * 0.05),
            Text("Confirm Password", style: AppFonts.blackbold14),
            SizedBox(height: height * 0.015),
             CustomTextFormField(
              hintText: "Confirm your password",
              prefixIconData: CupertinoIcons.padlock,
              isActive: false, isPassword: true, controller: rePasswordController,
            ),
            SizedBox(height: height * 0.04),
            CustomButtom(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: height * 0.02),
                            Text(
                              'Success !',
                              style: AppFonts.blackbold40,
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Your password has changed\nyou now log in with new password",
                              textAlign: TextAlign.center,
                              style: AppFonts.blackbold16,
                            ),
                            SizedBox(height: height * 0.02),
                            Image.asset(
                              AppAssets.suc,
                              width: 150,
                            ),
                            SizedBox(height: height * 0.03),
                            CustomButtom(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                      (route) => false,
                                );
                              },
                              text: "Back to Login",
                              color: AppColors.movColor,
                              borderColor: AppColors.movColor,
                              width: double.infinity,
                              height: height * 0.06,
                              textStyle: AppFonts.whitemedium16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              text: "Reset password",
              color: AppColors.movColor,
              borderColor: AppColors.movColor,
              width: double.infinity,
              height: height * 0.06,
              textStyle: AppFonts.whitemedium16,
            ),
          ],
        ),
      ),
    );
  }
}

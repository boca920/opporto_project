import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/featuers/register/register_view.dart';
import '../../core/ui/onboarding3.dart';
import '../../core/widget/drop_down_button.dart';
import 'forget_password.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
        title: Text(
          "Welcome back",
          style: AppFonts.movbold18,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.movColor),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Onboarding3(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.02),

            Image.asset(
              AppAssets.login,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login as", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomDropDownButton(),
                  SizedBox(height: height * 0.02),

                  Text("Email Address", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your Email",
                    prefixIconData: CupertinoIcons.mail,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("password", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your password",
                    prefixIconData: CupertinoIcons.padlock_solid,
                  ),
                  SizedBox(height: height * 0.01),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password",
                      style: AppFonts.blueBold14,
                    ),
                  ),

                  SizedBox(height: height * 0.06),

                  CustomButtom(
                    text: "Login",
                    color: AppColors.movColor,
                    borderColor: AppColors.movColor,
                    width: width * 380,
                    height: height * 0.060,
                    textStyle: AppFonts.whiteSemiBold18,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomButtom(
                    text: "Register Now",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
                        ),
                      );
                    },
                    color: AppColors.transparent,
                    borderColor: AppColors.movColor,
                    width: width * 380,
                    height: height * 0.060,
                    textStyle: AppFonts.movbold18,
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/ui/onboarding1.dart';
import '../../core/widget/drop_down_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Onboarding3(),
              ),
            );
          },
        ),
        title: Text(
          "Register now",
          style: AppFonts.movbold18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.02),

            Image.asset(
              AppAssets.register,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register as", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomDropDownButton(),
                  SizedBox(height: height * 0.02),

                  Text("Name", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your name",
                    prefixIconData: CupertinoIcons.pen,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("Email address", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your email",
                    prefixIconData: CupertinoIcons.mail,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("phone number", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your phone",
                    prefixIconData: CupertinoIcons.phone,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("password", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),

                  CustomTextFormField(
                    hintText: "Enter your password",
                    prefixIconData: CupertinoIcons.padlock_solid,
                  ),
                  SizedBox(height: height * 0.04),

                  CustomButtom(
                    text: "Register",
                    color: AppColors.movColor,
                    borderColor: AppColors.movColor,
                    width: width * 380,
                    height: height * 0.060,
                    textStyle: AppFonts.whiteSemiBold18,
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

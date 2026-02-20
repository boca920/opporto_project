import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/drop_down_button.dart';
import 'package:opporto_project/featuers/profile/create_profile.dart';
import '../../core/provider/user_provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
              MaterialPageRoute(builder: (context) => Onboarding3()),
            );
          },
        ),
        title: Text("Register now", style: AppFonts.movbold18),
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
                    isPassword: false,
                    controller: nameController,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("Email address", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: "Enter your email",
                    prefixIconData: CupertinoIcons.mail,
                    isPassword: false,
                    controller: emailController,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("Phone number", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: "Enter your phone",
                    prefixIconData: CupertinoIcons.phone,
                    isPassword: false,
                    controller: phoneController,
                  ),
                  SizedBox(height: height * 0.02),

                  Text("Password", style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: "Enter your password",
                    prefixIconData: CupertinoIcons.padlock_solid,
                    isPassword: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: height * 0.04),

                  CustomButtom(
                    text: "Register",
                    onTap: () {

                      Provider.of<UserProvider>(context, listen: false).updateUser(
                        fullName: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateProfile(
                            fullName: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                          ),
                        ),
                      );
                    },
                    color: AppColors.movColor,
                    borderColor: AppColors.movColor,
                    width: width * 0.9,
                    height: height * 0.06,
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
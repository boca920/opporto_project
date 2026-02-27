import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/drop_down_button.dart';
import 'package:opporto_project/featuers/profile/create_profile.dart';
import 'package:opporto_project/featuers/Company/account.dart';
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
              MaterialPageRoute(builder: (context) => const Onboarding3()),
            );
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.registernow,
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
                  Text(
                    AppLocalizations.of(context)!.registeras,
                    style: AppFonts.movbold18,
                  ),
                  SizedBox(height: height * 0.01),
                  const CustomDropDownButton(),
                  SizedBox(height: height * 0.02),

                  Text(AppLocalizations.of(context)!.name, style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.entername,
                    prefixIconData: CupertinoIcons.pen,
                    isPassword: false,
                    controller: nameController,
                  ),
                  SizedBox(height: height * 0.02),

                  Text(AppLocalizations.of(context)!.emailaddress, style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.enteremail,
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
                      String selectedRole =
                          Provider.of<UserProvider>(context, listen: false).role;

                      String email = emailController.text.trim();
                      String fullName = nameController.text.trim();
                      String phone = phoneController.text.trim();
                      String address = addressController.text.trim();

                      // تحديث الـ Provider
                      Provider.of<UserProvider>(context, listen: false).updateUser(
                        fullName: fullName,
                        email: email,
                        phone: phone,
                        address: address,
                      );

                      // الانتقال للشاشة المناسبة
                      if (selectedRole.toLowerCase() == "company") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Account()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateProfile(
                              fullName: fullName,
                              email: email,
                              phone: phone,
                              address: address,
                            ),
                          ),
                        );
                      }
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
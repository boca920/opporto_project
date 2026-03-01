import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/home/home_view.dart';
import 'package:opporto_project/featuers/register/register_view.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import '../../core/ui/onboarding3.dart';
import '../../core/widget/drop_down_button.dart';
import 'forget_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.welcomeback,
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
                  Text(AppLocalizations.of(context)!.emailaddress, style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.enteremail,
                    prefixIconData: CupertinoIcons.mail, isPassword: false, controller: emailController,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(AppLocalizations.of(context)!.password, style: AppFonts.movbold18),
                  SizedBox(height: height * 0.01),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.enterpass,
                    prefixIconData: CupertinoIcons.padlock_solid, isPassword: false, controller: passwordController,
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
                      AppLocalizations.of(context)!.forget,
                      style: AppFonts.blueBold14,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  CustomButtom(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimatedNavBar(initialIndex: 0,),
                        ),
                      );
                    },
                    text:AppLocalizations.of(context)!.login,
                    color: AppColors.movColor,
                    borderColor: AppColors.movColor,
                    width: width * 380,
                    height: height * 0.060,
                    textStyle: AppFonts.whiteSemiBold18,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomButtom(
                    text: AppLocalizations.of(context)!.registernow,
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
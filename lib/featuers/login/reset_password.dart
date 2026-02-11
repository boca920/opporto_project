import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      builder: (context) =>  ForgetPassword(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body:  Padding(
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
              hintTextStyle: AppFonts.graybold14,
              prefixIconData: CupertinoIcons.padlock,
              isActive: false,
            ),
            SizedBox(height: height * 0.05),
            Text("Confirm Password", style: AppFonts.blackbold14),
            SizedBox(height: height * 0.015),
            CustomTextFormField(
              hintText: "Enter your password",
              hintTextStyle: AppFonts.graybold14,
              prefixIconData: CupertinoIcons.padlock,
              isActive: false,
            ),
            SizedBox(height: height * 0.025),
            CustomButtom(
              onTap:  (){showAdaptiveDialog(context: context, builder: (context){
                return Container(

                );
              },);},
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

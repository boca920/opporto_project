import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding2.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.whiteColor, AppColors.movColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),

            Image.asset(AppAssets.onboarding1, width: 700, fit: BoxFit.contain),

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("opporto", style: AppFonts.whiteSplash40),
                  SizedBox(height: height * 0.015),
                  Text(
                    "your dream jop is waiting.",
                    style: AppFonts.whiteSemiBold18,
                  ),

                  SizedBox(height: height * 0.015),
                  Text(
                    "Get smart jop recommendations based \non your experience and take the next\nstep up the ladder",
                    style: AppFonts.whiteRegular16,
                  ),
                  SizedBox(height: height * 0.035),
                  Center(
                    child: CustomButtom(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Onboarding2(),
                          ),
                        );
                      },
                      text: "Next",
                      color: AppColors.whiteColor,
                      borderColor: AppColors.movColor,
                      width: width * 380,
                      height: height * 0.060,
                      textStyle: AppFonts.movbold16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

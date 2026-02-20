import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.05),

          Image.asset(AppAssets.onboarding2, width: 700, fit: BoxFit.contain),

          SizedBox(height: height * 0.06),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find the Right Role for You",
                  style: AppFonts.movSemiBold18,
                ),
                SizedBox(height: height * 0.01),

                Text(
                  "Customize your search to discover \njob openings that truly align with your \ncareer goals.",
                  style: AppFonts.grayRegular16,
                ),

                SizedBox(height: height * 0.14),

                Center(
                  child: CustomButtom(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Onboarding3()),
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
    );
  }
}

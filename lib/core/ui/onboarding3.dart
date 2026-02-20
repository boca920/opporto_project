import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/register/register_view.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';
import '../widget/custom_data.dart';


class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.04),
          Image.asset(
            AppAssets.onboarding3,
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Text(
                  "Find a jop that suits your \nintersests and skills",
                  style: AppFonts.movbold24,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Discover jop opportunities that match\n your skills and passions connect with\n employers seeking talent like yours for\n rewarding careers",
                  style: AppFonts.grayRegular16,
                ),
                SizedBox(height: height * 0.017),
                CustomData(
                  text: "1,23,411",
                  text1: 'live jop',
                  image: AppAssets.data1,
                ),
                SizedBox(height: height * 0.02),
                CustomData(
                  text: "91220",
                  text1: 'companies',
                  image: AppAssets.data2,
                ),
                SizedBox(height: height * 0.02),
                CustomData(
                  text: "2,34,200",
                  text1: 'jop seeker',
                  image: AppAssets.data3,
                ),
                SizedBox(height: height * 0.02),
                CustomData(
                  text: "1,03,761",
                  text1: 'Employers',
                   image: AppAssets.data4,
                ),
                SizedBox(height: height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtom(
                      text: "Login",
                      onTap: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginView()));},
                      color: AppColors.transparent,
                      borderColor: AppColors.movColor,
                      width: 180,
                      height: 54,
                      textStyle: AppFonts.movSemiBold18,

                    ),
                    SizedBox(width: width * 0.04),
                    CustomButtom(
                      text: "get started",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterView()),
                        );
                      },

                      color: AppColors.movColor,
                      borderColor: AppColors.movColor,
                      width: 180,
                      height: 54,
                      textStyle: AppFonts.whiteSemiBold18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

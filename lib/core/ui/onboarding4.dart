import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/register/register_view.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              flex: 5,
              child: Center(
                child: Image.asset(
                  AppAssets.onboarding4,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),


            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                                         "Discover jobs that match\n                 your skills",
                        style: AppFonts.movbold24,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Text(
                      "Build your future with the right opportunity.",
                      style: AppFonts.grayRegular16,
                    ),
                    SizedBox(height: height*0.08,),
                    Center(
                      child: Column(
                        children: [

                          const SizedBox(height: 15),
                          CustomButtom(
                            width: width * 0.8,
                            text: "Next",
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Onboarding3(),
                                ),
                              );
                            },
                            color: AppColors.movColor,
                            borderColor: AppColors.movColor,
                            height: 54,
                            textStyle: AppFonts.whiteSemiBold18,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
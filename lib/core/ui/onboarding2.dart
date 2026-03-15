import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // الصورة (50% من المساحة)
            Expanded(
              flex: 5,
              child: Center(
                child: Image.asset(
                  AppAssets.onboarding2,
                  width: width * 0.85,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // المحتوى (40% من المساحة)
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Let’s Start Build Your Career",
                      style: AppFonts.movbold32,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.customizeyoursearch,
                      style: AppFonts.graybold14,
                    ),
                    const Spacer(),
                    Center(
                      child: CustomButtom(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Onboarding3(),
                            ),
                          );
                        },
                        text: AppLocalizations.of(context)!.next,
                        color: AppColors.movColor,
                        borderColor: AppColors.lightmov,
                        width: width * 0.8,
                        height: 54,
                        textStyle: AppFonts.whiteSemiBold18,
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
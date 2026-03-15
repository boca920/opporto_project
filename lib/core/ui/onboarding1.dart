import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding2.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.movColor, AppColors.movColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // الصورة (50% من المساحة)
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset(
                    AppAssets.onboarding1,
                    width: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "opporto",
                        style: AppFonts.whiteSplash40,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppLocalizations.of(context)!.yourdream,
                        style: AppFonts.whiteSemiBold18,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppLocalizations.of(context)!.getsmartjop,
                        style: AppFonts.whiteRegular16,
                      ),
                      const Spacer(),
                      Center(
                        child: CustomButtom(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Onboarding2(),
                              ),
                            );
                          },
                          text: AppLocalizations.of(context)!.next,
                          color: AppColors.whiteColor,
                          borderColor: AppColors.movColor,
                          width: width * 0.8,
                          height: 54,
                          textStyle: AppFonts.movbold16,
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
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/register/register_view.dart';
import 'package:opporto_project/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../widget/custom_buttom.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
                  AppAssets.onboarding3,
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
                      AppLocalizations.of(context)!.findajob,
                      style: AppFonts.movbold24,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      AppLocalizations.of(context)!.discoverjobopport,
                      style: AppFonts.grayRegular16,
                    ),
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          CustomButtom(
                            width: width * 0.8,
                            text: AppLocalizations.of(context)!.login,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            color: AppColors.transparent,
                            borderColor: AppColors.movColor,
                            height: 54,
                            textStyle: AppFonts.movSemiBold18,
                          ),
                          const SizedBox(height: 15),
                          CustomButtom(
                            width: width * 0.8,
                            text: AppLocalizations.of(context)!.register,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterView(),
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
import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding1.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controllerLogo;
  late AnimationController _controllerTagline;

  late Animation<double> _fadeLogo;
  late Animation<Offset> _slideLogo;

  late Animation<double> _fadeTagline;
  late Animation<Offset> _slideTagline;

  bool replaceFirstO = false;

  final List<String> letters = ['O', 'P', 'P', 'O', 'R', 'T', 'O'];

  @override
  void initState() {
    super.initState();

    // 🔹 Logo Animation
    _controllerLogo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeLogo = CurvedAnimation(
      parent: _controllerLogo,
      curve: Curves.easeInOut,
    );
    _slideLogo = Tween<Offset>(begin: const Offset(0, 0.10), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _controllerLogo, curve: Curves.easeOutCubic),
        );

    _controllerLogo.forward();

    // 🔹 Tagline Animation
    _controllerTagline = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeTagline = CurvedAnimation(
      parent: _controllerTagline,
      curve: Curves.easeIn,
    );
    _slideTagline =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controllerTagline,
            curve: Curves.easeOutCubic,
          ),
        );

    // تبديل أول O → Icon بعد 2.2 ثانية
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => replaceFirstO = true);
      _controllerTagline.forward(); // إطلاق ظهور Tagline
    });

    // الانتقال لصفحة Onboarding بعد 6 ثواني
    Future.delayed(const Duration(milliseconds: 6000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboarding1()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    _controllerTagline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.movColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Logo OPPORTO
            FadeTransition(
              opacity: _fadeLogo,
              child: SlideTransition(
                position: _slideLogo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(letters.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: index == 0
                          ? AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1000),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: replaceFirstO
                                  ? Image.asset(
                                      'assets/images/icon.png',
                                      key: const ValueKey('icon'),
                                      width: 60,
                                    )
                                  : Text(
                                      letters[index],
                                      key: const ValueKey('text'),
                                      style: AppFonts.whiteSplash60,
                                    ),
                            )
                          : Text(letters[index], style: AppFonts.whiteSplash60),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 30),


            FadeTransition(
              opacity: _fadeTagline,
              child: SlideTransition(
                position: _slideTagline,
                child: Text(
                  'Find your dream job easily.',
                  style: AppFonts.whitemedium16,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

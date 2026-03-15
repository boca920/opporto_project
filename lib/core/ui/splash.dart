import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/onboarding1.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with TickerProviderStateMixin {
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

    // 1. Animation Controller for Logo (Slide + Fade)
    _controllerLogo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeLogo = CurvedAnimation(
      parent: _controllerLogo,
      curve: Curves.easeInOut,
    );

    // Slide from bottom with a bounce effect
    _slideLogo = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controllerLogo,
      curve: Curves.easeOutBack, // يعطي تأثير القفزة الخفيفة
    ));

    _controllerLogo.forward();

    // 2. Animation Controller for Tagline (Fade + Slide)
    _controllerTagline = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeTagline = CurvedAnimation(
      parent: _controllerTagline,
      curve: Curves.easeIn,
    );

    _slideTagline = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controllerTagline,
      curve: Curves.easeOutCubic,
    ));

    // 3. Timing Logic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // بعد 2.2 ثانية: تبديل الحرف الأول وبدء أنيميشن الشعار
      Future.delayed(const Duration(milliseconds: 2200), () {
        if (mounted) {
          setState(() => replaceFirstO = true);
          _controllerTagline.forward();
        }
      });

      // بعد 6 ثواني: الانتقال للشاشة التالية
      Future.delayed(const Duration(milliseconds: 6000), () {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(builder: (_) => const Onboarding1()),
        );
      });
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        // خلفية متدرجة لإعطاء طابع احترافي
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.movColor, // لونك الأساسي
                Color(0xFF1a1a2e),  // لون أغمق قليلاً للخلفية
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. أنيميشن اللوجو
                  FadeTransition(
                    opacity: _fadeLogo,
                    child: SlideTransition(
                      position: _slideLogo,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(letters.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: index == 0
                                ? AnimatedSwitcher(
                              duration: const Duration(milliseconds: 800),
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
                                height: 60,
                                fit: BoxFit.contain,
                              )
                                  : Text(
                                letters[index],
                                key: const ValueKey('text'),
                                style: AppFonts.whiteSplash60,
                              ),
                            )
                                : Text(
                              letters[index],
                              style: AppFonts.whiteSplash60,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 2. أنيميشن الشعار (Tagline) - اختياري لإكمال الأنيميشن
                  // يمكنك حذف هذا الجزء إذا لم تكن تريد نصاً إضافياً
                  FadeTransition(
                    opacity: _fadeTagline,
                    child: SlideTransition(
                      position: _slideTagline,
                      child: const Text(
                        "Welcome to Opporto", // يمكنك تغيير النص حسب الحاجة
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
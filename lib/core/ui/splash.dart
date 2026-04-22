import 'package:flutter/material.dart';
import 'package:opporto_project/core/services/shared_prefs.dart';
import 'package:opporto_project/core/ui/onboarding1.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/featuers/login/login_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // 1) Icon entrance (center)
  late final Animation<double> _iconOpacity;
  late final Animation<double> _iconScale;

  // 2) Icon moves left
  late final Animation<double> _iconShiftX;

  // 3) Word reveal
  late final Animation<double> _wordReveal;
  late final Animation<double> _wordOpacity;
  late final Animation<double> _wordSlide;

  // 4) Tagline reveal
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _taglineSlideY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );

    _iconOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.00, 0.22, curve: Curves.easeOut),
    );

    _iconScale = Tween<double>(begin: 0.58, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.00, 0.28, curve: Curves.easeOutBack),
      ),
    );

    _iconShiftX = Tween<double>(begin: 0, end: -14).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.58, curve: Curves.easeInOutCubic),
      ),
    );

    _wordReveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.42, 0.82, curve: Curves.easeOutCubic),
    );

    _wordOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.46, 0.82, curve: Curves.easeOut),
    );

    _wordSlide = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.42, 0.82, curve: Curves.easeOutCubic),
    );

    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.72, 1.00, curve: Curves.easeIn),
    );

    _taglineSlideY = Tween<double>(begin: 8, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.72, 1.00, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 5200), () async {
      if (!mounted) return;

      bool? seen = SharedPrefs.getBool('onboardingSeen');

      if (seen == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Onboarding1()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.movColor,
                Color(0xFF1A1A2E),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 78,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.translate(
                              offset: Offset(_iconShiftX.value, 0),
                              child: Opacity(
                                opacity: _iconOpacity.value,
                                child: Transform.scale(
                                  scale: _iconScale.value,
                                  child: Image.asset(
                                    'assets/images/icon.png',
                                    width: 62,
                                    height: 62,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 0),
                            ClipRect(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: _wordReveal.value,
                                child: Opacity(
                                  opacity: _wordOpacity.value,
                                  child: Transform.translate(
                                    offset: Offset(
                                      (1 - _wordSlide.value) * 18,
                                      0,
                                    ),
                                    child: Text(
                                      'OPPORTO',
                                      style: AppFonts.whiteSplash60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Opacity(
                        opacity: _taglineOpacity.value,
                        child: Transform.translate(
                          offset: Offset(0, _taglineSlideY.value),
                          child: const Text(
                            'Smart opportunities, better future',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
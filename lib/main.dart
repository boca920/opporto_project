
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opporto_project/core/ui/onboarding1.dart';
import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/core/provider/provider_language.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'core/provider/user_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/provider/user_roles_provider.dart';

void main() async {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRolesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageProvider.appLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: "AI Chat Assistant",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xff0A0A0A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: Splash(),
    );
  }
}

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/core/provider/provider_language.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/core/provider/user_roles_provider.dart';


import 'core/provider/jop_provider.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await dotenv.load();




  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRolesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
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


      home: Splash(),
    );
  }
}
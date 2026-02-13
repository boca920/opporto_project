import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/splash.dart';
import 'package:provider/provider.dart';
import 'core/provider/user_roles_provider.dart';

import 'featuers/profile/create_profile.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRolesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

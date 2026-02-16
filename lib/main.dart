import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/profile/profile_view.dart';
import 'package:provider/provider.dart';
import 'core/chat/chat_home.dart';
import 'core/provider/user_provider.dart';
import 'core/provider/user_roles_provider.dart';

import 'featuers/profile/create_profile.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRolesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
      title: "AI Chat Assistant",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xff0A0A0A),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,

        )

      ),
      home: ChatHome(),
    );
  }
}

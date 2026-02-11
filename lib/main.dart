import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/featuers/otp/otp_view.dart';
import 'package:opporto_project/featuers/register/register_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}


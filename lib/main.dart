import 'package:flutter/material.dart';
import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/featuers/Company/home.dart';
import 'package:provider/provider.dart';
import 'core/provider/user_provider.dart';
import 'core/provider/user_roles_provider.dart';

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
    return MaterialApp(home: Splash());

    //     return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         title: "AI Chat Assistant",
    //         theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //             scaffoldBackgroundColor: Color(0xff0A0A0A),
    //             appBarTheme: AppBarTheme(
    //               backgroundColor: Colors.transparent,
    //               elevation: 0,
    //               systemOverlayStyle: SystemUiOverlayStyle.light,
    //             )
    //         ),
    //           home:RegisterView()
    //     );
  }
}

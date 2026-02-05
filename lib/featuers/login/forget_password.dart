import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/featuers/login/login_view.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.25),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,

          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios, color: AppColors.movColor),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const LoginView(),
          //       ),
          //     );
          //   },
          // ),
          // centerTitle: true,

        ),
      ),

      body: Column(
        children: [
          Text("data")
        ],
      ),
    );
  }
}

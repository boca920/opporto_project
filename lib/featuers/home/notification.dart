import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,size: 20,),
          onPressed: () {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AnimatedNavBar(initialIndex: 0,),
              ),
            );
          },
        ),
        title:  Text('Notifications',style: AppFonts.blackbold18,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          children: [
            SizedBox(height:height*0.1 ,),
            Text(
              'Empty',style: AppFonts.movbold24,

            ),
            SizedBox(height: height*0.02,),
            Text("you dont have any notification at this time",style: AppFonts.blackbold16,)
          ],
        ),
      ),
    );
  }
}
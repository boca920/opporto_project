import 'package:flutter/cupertino.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class CustomData extends StatelessWidget {
  final String text;
  final String text1;
  final String image;
  const CustomData({super.key, required this.text, required this.text1, required this.image});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container(

      width: 246,
      height: 50,

      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkGrayColor),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Image.asset(image,fit: BoxFit.fill,),
          SizedBox(width: width*0.03,),
          Text(text,style: AppFonts.movSemiBold18,),
          SizedBox(width: width*0.03,),
          Text(text1,style: AppFonts.graybold14,)
        ],
      ),
    );
  }
}

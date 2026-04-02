import 'package:flutter/material.dart';

import '../screens/notifications_screen/notifications_screen.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showNotification;
  final VoidCallback? onBack;
  final bool isBack ;



  const CustomHeader({
    super.key,
    required this.title,
    required this.isBack ,
    this.onBack,
    this.showNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 100 + topPadding * 0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3730A3), Color(0xFF262170), Color(0xFF15123D)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      padding: EdgeInsets.only(top: topPadding, left: 16, right: 16,bottom: 16 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 20,
        children: [
          isBack != true
              ? Container()
              : Visibility(
              visible: isBack,
              child:IconButton(
              onPressed: onBack,
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)) ),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Spacer(),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Last()));
          }, icon: Icon(Icons.notifications, color: showNotification ? Colors.grey: Colors.amber))

        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/Company/Application.dart';

class Last extends StatefulWidget {
  const Last({super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Application()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [Icon(Icons.close)],
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Notification",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 343,
                    height: 79,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff3730a399)),
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffDDDCF0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Ahmed Bassil accepted the interview.",
                            style: TextStyle(color: Color(0xff3730A3)),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Color(0xff3730A3),
                              ),
                              Text(
                                "12 mins",
                                style: TextStyle(color: Color(0xff3730A3) , fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/calendar_screen/calendar_screen.dart';


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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),

          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Notification",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: double.infinity,
                    height: 79,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xff3730a399)),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffDDDCF0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Ahmed Bassil accepted the interview.",
                            style: TextStyle(color: Color(0xff3730A3)),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 18,
                                color: Color(0xff3730A3),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "12 mins",
                                style: TextStyle(color: Color(0xff3730A3), fontSize: 12),
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
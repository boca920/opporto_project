import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Application extends StatefulWidget {
  @override
  State<Application> createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  int currentIndex = 0;

  String get currentDate {
    final now = DateTime.now();
    return "${now.year}/${now.month}/${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  SizedBox(height: 28),

                  Container(
                    height: 48,
                    width: 358,
                    color: Color(0xFFCECECE),
                    child: Center(
                      child: Text(
                        "Application from job seekers",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Name: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "Mark kamel ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Email: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "markkamel@gmail.com ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Phone: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "+30 1558604028",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Address: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "Maadi, Cairo, Egypt ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Cover letter: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Container(
                                width: 250,
                                child: Text(
                                  " Iam frontend developer react.js cssHtml js ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "status: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "under-graduate ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "CV",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 36, top: 12),
                    child: Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 41,
                                height: 41,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(25, 0, 0, 0),
                                  ),
                                ),
                                child: Image.asset(
                                  "assets/images/application.png",
                                ),
                              ),

                              SizedBox(width: 12),
                              Text(
                                "Mark Kamel.pdf",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 41,
                                height: 41,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(10, 0, 0, 0),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(10, 0, 0, 0),
                                  ),
                                ),
                                child: Image.asset("assets/images/editpen.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(left: 24, top: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mark kamel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Junior Front-End Developer",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(left: 24, top: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Under-graduate",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(left: 24, top: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top 5 skills",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 120,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Web design",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 120,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "technology",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 120,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Marketing",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 120,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "programming",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 120,
                                  child: Card(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        "Web design",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 104.0,
                            height: 42.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF0C830A), Color(0xFF143A13)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 104.0,
                            height: 42.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF5555), Color(0xFF993333)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'failed',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                         const SizedBox(width: 12),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 104.0,
                            height: 42.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFF9F2E6), Color(0xFF938F88)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'on hold',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF69800),
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                
                        
                        
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          _bottomBar(context, height),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 77,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3730A3), Color(0xFF262170), Color(0xFF15123D)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              const Text(
                "Application",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Image.asset("assets/images/notification2.png", width: 24),
        ],
      ),
    );
  }

  Widget buildTag(String text) {
    return Container(
      width: 90,
      height: 26.0,
      decoration: BoxDecoration(
        color: const Color(0x0D000000),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: const Color(0x19000000), width: 1.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xbacd4b4b4b),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1D177A),
            ),
          ),
          Expanded(child: Text(value, style: GoogleFonts.inter())),
        ],
      ),
    );
  }

  Widget _bottomBar(BuildContext context, double height) {
    return Container(
      height: height * 0.09,
      color: const Color(0xFF00205B),
      child: Stack(
        children: [
          Container(height: 25.8, color: Colors.white),
          _navItem(-0.89, 0.96, Icons.home, "Home", false, () {}),
          _navItem(-0.40, 0.96, Icons.add_box_outlined, "Jobs", false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Postnewjob()),
            );
          }),
          _navItem(0.20, -0.41, Icons.assignment, "Application", true, () {}),
          _navItem(0.82, 0.96, Icons.person, "Profile", false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Account()),
            );
          }),
        ],
      ),
    );
  }

  Widget _navItem(
    double x,
    double y,
    IconData icon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    return Align(
      alignment: AlignmentDirectional(x, y),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? Colors.white : const Color(0xFF00205B),
              ),
              child: Icon(
                icon,
                color: active ? const Color(0xFF00205B) : Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

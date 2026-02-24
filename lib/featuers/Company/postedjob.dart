import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/Application.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/home.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Postedjob extends StatefulWidget {
  final String jobTitle;
  final String country;
  final String city;
  final String description;
  final String location;

  const Postedjob({
    super.key,
    required this.jobTitle,
    required this.country,
    required this.city,
    required this.description,
    required this.location,
  });

  @override
  State<Postedjob> createState() => _PostedjobState();
}

class _PostedjobState extends State<Postedjob> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 77,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3730A3),
                          Color(0xFF262170),
                          Color(0xFF15123D),
                        ],
                        begin: AlignmentDirectional(1.0, 0.0),
                        end: AlignmentDirectional(-1.0, 0.0),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Postnewjob(),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                        Text(
                          ' job details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            22.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            width: 227.7,
                            height: 64.0,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 64.0,
                                  height: 64.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 41.0,
                                      height: 41.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0x4C57636C),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Image.asset(
                                          'assets/images/twitter2.png',
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 163.4,
                                  height: 41.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Junior Front End',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              4.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Text(
                                          'New Cairo, Egypt',
                                          style: GoogleFonts.inter(
                                            fontSize: 12.0,
                                            letterSpacing: 0.5,
                                            color: const Color(0xbacd333333),
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

                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            16.0,
                            0.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 26.0,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    12.0,
                                    0.0,
                                  ),
                                  child: buildTag('Full time'),
                                ),
                                buildTag('Junior'),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: buildTag('Remotely'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 24),
                    child: Text(
                      "Job Details",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D177A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  buildDetailRow("Title", widget.jobTitle),
                  buildDetailRow("Country", widget.country),
                  buildDetailRow("City", widget.city),
                  buildDetailRow("Location", widget.location),
                  buildDetailRow("Category", "Front End Developer"),
                  buildDetailRow("Salary", "10000"),
                  buildDetailRow("Posted On", currentDate),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Description",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color(0xFF1D177A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      widget.description,
                      style: GoogleFonts.inter(fontSize: 14),
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
                                colors: [Color(0xFFF06400), Color(0xFF8A3A00)],
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
                                'delete',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
          _bottomBar(context, height),
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
          _navItem(-0.89, 0.96, Icons.home, "Home", false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Home()),
            );
          }),
          _navItem(-0.40, 0.96, Icons.add_box_outlined, "Jobs", false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Postnewjob()),
            );
          }),
          _navItem(0.20, -0.41, Icons.assignment, "Application", true, () 
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Application()),
            );
          }),
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

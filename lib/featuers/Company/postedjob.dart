import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Postedjob extends StatefulWidget {
  final String jobTitle;
  final String country;
  final String city;
  final String description;
  final String Location;

  const Postedjob({
    super.key,
    required this.jobTitle,
    required this.country,
    required this.city,
    required this.description,
    required this.Location,
  });

  static const String routeName = 'postedjob';
  static const String routePath = '/Postedjob';

  @override
  State<Postedjob> createState() => _PostedjobState();
}

class _PostedjobState extends State<Postedjob> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController textController1 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  InputDecoration buildInputDecoration({required String hint}) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: const Color(0xBACD757575),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  TextStyle buildMainTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color color = const Color(0xBACD6A6A6A),
    double letterSpacing = 0.0,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // page
            Container(
              height: height * 0.91,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(width: 394.9, height: 44.08, color: Colors.white),

                    // Header Gradient
                    Container(
                      width: 390.0,
                      height: 77.0,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3730A3),
                            Color(0xFF262170),
                            Color(0xFF15123D),
                          ],
                          stops: [0.0, 1.0, 1.0],
                          begin: AlignmentDirectional(1.0, 0.0),
                          end: AlignmentDirectional(-1.0, 0.0),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Text(
                            'Post new job',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title Section
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        8.0,
                        0.0,
                        0.0,
                      ),
                      child: Container(
                        width: 390,
                        height: 70.0,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Create opportunity',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: const Color(0xFF272273),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                24.0,
                                0.0,
                                0.0,
                              ),
                              child: Text(
                                'Fill in the details to reach top talent',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: const Color(0xBACD717171),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Job Preview Section
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
                            Container(
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
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 163.4,
                              height: 41.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.jobTitle,
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
                                        color: const Color(0xBACD333333),
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

                    // Tags Row
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        16.0,
                        0.0,
                        0.0,
                      ),
                      child: Container(
                        width: 247.0,
                        height: 26.0,
                        color: Colors.white,
                        child: Row(
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

                    // Job Details
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(18, 24, 0, 0),
                        child: Text(
                          "Job details",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 195, 5, 5),
                          ),
                        ),
                      ),
                    ),

                    // Job Details description
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Column(
                        children: [
                          // title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "title : ",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color(0xFF1D177A),
                                ),
                              ),
                              SizedBox(width: 5),
                              // Here we display the job title passed from the previous screen
                              Text(
                                widget.jobTitle,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                          // category
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "category : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  "Front End web developer",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // country
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Country : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  widget.country,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // city
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "City : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  widget.city,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Location
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Location : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  widget.Location,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // salary
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Salary : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  "10000",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // job date
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "job posted on : ",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xFF1D177A),
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Here we display the job title passed from the previous screen
                                Text(
                                  "2025/12/17",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "job description : ",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: const Color(0xFF1D177A),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  // Here we display the job title passed from the previous screen
                                  Text(
                                    widget.description,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 24),
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
                                        colors: [
                                          Color(0xFFF06400),
                                          Color(0xFF8A3A00),
                                        ],
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
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 104.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF5555),
                                          Color(0xFF993333),
                                        ],
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
                  ],
                ),
              ),
            ),

            // bottom navigation bar
            Container(
              width: 431.0,
              height: height * 0.09,
              decoration: const BoxDecoration(color: Color(0xFF00205B)),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 25.8,
                    color: Colors.white,
                  ),

                  // ================= Jobs =================
                  Align(
                    alignment: const AlignmentDirectional(-0.40, -0.41),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Postnewjob(),
              ),
            );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_box_outlined,
                              color: Color(0xFF00205B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Jobs",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ================= Profile =================
                  Align(
                    alignment: const AlignmentDirectional(0.82, 0.96),
                    child: GestureDetector(
                      onTap: () {
                        print("Profile tapped");
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00205B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ================= Home =================
                  Align(
                    alignment: const AlignmentDirectional(-0.89, 0.96),
                    child: GestureDetector(
                      onTap: () {
                        print("Home tapped");
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00205B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.home, color: Colors.white),
                          ),
                          const Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ================= Application =================
                  Align(
                    alignment: const AlignmentDirectional(0.20, 0.96),
                    child: GestureDetector(
                      onTap: () {
                        print("Application tapped");
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00205B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.assignment,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Application",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tag Widget
  Widget buildTag(String text) {
    return Container(
      width: 74.3,
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
              color: const Color(0xBACD4B4B4B),
            ),
          ),
        ),
      ),
    );
  }
}

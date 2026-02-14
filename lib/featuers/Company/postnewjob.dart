import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/postedjob.dart';

class Postnewjob extends StatefulWidget {
  const Postnewjob({super.key});

  static const String routeName = 'postnewjob';
  static const String routePath = '/Postnewjob';

  @override
  State<Postnewjob> createState() => _PostnewjobState();
}

class _PostnewjobState extends State<Postnewjob> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Text Controllers
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;

  // Focus Nodes
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  // Dropdown Values
  String? dropDownValue1;
  String? dropDownValue2;

  @override
  void initState() {
    super.initState();

    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0,
                          0.0,
                          0.0,
                          0.0,
                        ),
                        child: Text(
                          'Post new job',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                                  'Junior Front End',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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

                  // Form Section
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      24.0,
                      0.0,
                      0.0,
                    ),
                    child: Container(
                      width: 371.0,
                      height: 688.0,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Job Title
                          buildLabelField(
                            label: 'Job title',
                            child: buildTextField(
                              controller: textController1,
                              focusNode: focusNode1,
                              hint: 'junior front end developer',
                            ),
                          ),

                          // Category Dropdown
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              24.0,
                              0.0,
                              0.0,
                            ),
                            child: buildDropdownSection(
                              label: 'select category ',
                              value: dropDownValue1,
                              hint: 'choose categories…',
                              onChanged: (val) {
                                setState(() {
                                  dropDownValue1 = val;
                                });
                              },
                            ),
                          ),

                          // Country & City Row
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              24.0,
                              0.0,
                              0.0,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 171.0,
                                  child: buildLabelField(
                                    label: 'Country',
                                    child: buildTextField(
                                      controller: textController2,
                                      focusNode: focusNode2,
                                      hint: 'Country',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                SizedBox(
                                  width: 171.0,
                                  child: buildLabelField(
                                    label: 'City',
                                    child: buildTextField(
                                      controller: textController3,
                                      focusNode: focusNode3,
                                      hint: 'City',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Specific Location
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              24.0,
                              0.0,
                              0.0,
                            ),
                            child: buildLabelField(
                              label: 'Specific location',
                              child: buildTextField(
                                controller: textController4,
                                focusNode: focusNode4,
                                hint: 'e.g. 123 business st,tech hub',
                              ),
                            ),
                          ),

                          // Salary Dropdown
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              24.0,
                              0.0,
                              0.0,
                            ),
                            child: buildDropdownSection2(
                              label: 'select Salary type',
                              value: dropDownValue2,
                              hint: 'select salary type',
                              onChanged: (val) {
                                setState(() {
                                  dropDownValue2 = val;
                                });
                              },
                            ),
                          ),

                          // Job Description
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              24.0,
                              0.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'job description ',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: const Color(0xBACD2A257C),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  // padding: const EdgeInsets.all(12.0),
                                  width: 361.0,
                                  // height: 135.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: const Color(0xFF808080),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: textController5,
                                    focusNode: focusNode5,
                                    maxLines: 4,
                                    expands: false,
                                    decoration: buildInputDecoration(
                                      hint: 'e.g. 123 business st,tech hub',
                                    ),
                                    style: buildMainTextStyle(),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //  Last button
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      22.0,
                      0.0,
                      22.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Postedjob(
                              jobTitle: textController1.text,
                              country: textController2.text,
                              city: textController3.text,
                              description: textController5.text,
                              Location: textController4.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 358.0,
                        height: 53.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3730A3),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Post New Job',
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 431.0,
            height: height * 0.09,
            decoration: BoxDecoration(color: Color(0xFF00205B)),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 25.8,
                  color: Colors.white,
                ),

                InkWell(
                  onTap: () {},
                  child: Align(
                    alignment: AlignmentDirectional(-0.40, -0.41),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_box_outlined,
                            color: Color(0xFF00205B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
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

                InkWell(
                  child: Align(
                    alignment: AlignmentDirectional(0.82, 0.96),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFF00205B),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        Text(
                          "profile",
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

                InkWell(
                  child: Align(
                    alignment: AlignmentDirectional(-0.89, 0.96),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFF00205B),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.home, color: Colors.white),
                        ),
                        Text(
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

                InkWell(
                  child: Align(
                    alignment: AlignmentDirectional(0.20, 0.96),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFF00205B),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.assignment, color: Colors.white),
                        ),
                        Text(
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

  // Label + Field Wrapper
  Widget buildLabelField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 29.0,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: const Color(0xBACD2A257C),
              ),
            ),
          ),
        ),
        Container(
          width: 361.0,
          height: 53.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFF808080), width: 1.0),
          ),
          child: child,
        ),
      ],
    );
  }

  // TextField Builder
  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: buildInputDecoration(hint: hint),
      style: buildMainTextStyle(),
      cursorColor: Colors.black,
    );
  }

  // Dropdown Section Builder
  // for category
  Widget buildDropdownSection({
    required String label,
    required String hint,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: const Color(0xBACD2B257E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 361.0,
          height: 53.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFF707070), width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                hint: Text(
                  hint,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF757575),
                  ),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 24.0,
                ),
                items:
                    const [
                      ' Frontend',
                      ' backend',
                      ' Mobile ',
                      'UI/UX',
                      'DevOps',
                      'Data Analyst',
                    ].map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF757575),
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // for salary type
  Widget buildDropdownSection2({
    required String label,
    required String hint,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: const Color(0xBACD2B257E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 361.0,
          height: 53.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFF707070), width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                hint: Text(
                  hint,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF757575),
                  ),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 24.0,
                ),
                items:
                    const [
                      ' 1000',
                      ' 2000',
                      ' 3000 ',
                      '4000/6000',
                      '8000',
                      '10000 +',
                    ].map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF757575),
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

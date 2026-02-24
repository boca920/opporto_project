import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/Application.dart';
import 'package:opporto_project/featuers/Company/markkamel.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/home.dart';
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

  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  String? dropDownValue1;
  String? dropDownValue2;
  String? dropDownValuestate;
  String? dropDownValuetime;
  String? dropDownValueplace;

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height * 0.05),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                    child: const Center(
                      child: Text(
                        'Post new job',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
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
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFFC5C5C5),
                                    ),
                                    width: 64.0,
                                    height: 64.0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 41.0,
                                        height: 41.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFC5C5C5),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF767676),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 34,
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
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildDropdownSectiontime(
                              hint: "Fulltime",
                              value: dropDownValuetime,
                              onChanged: (val) {
                                setState(() {
                                  dropDownValuetime = val;
                                });
                              },
                            ),
                            SizedBox(width: 12),
                            buildDropdownSectionstate(
                              hint: "Junior",
                              value: dropDownValuestate,
                              onChanged: (val) {
                                setState(() {
                                  dropDownValuestate = val;
                                });
                              },
                            ),
                            SizedBox(width: 12),
                            buildDropdownSectionplace(
                              hint: "Onsite",
                              value: dropDownValueplace,
                              onChanged: (val) {
                                setState(() {
                                  dropDownValueplace = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildLabelField(
                          label: 'Job title',
                          child: buildTextField(
                            controller: textController1,
                            focusNode: focusNode1,
                            hint: 'junior front end developer',
                          ),
                        ),

                        const SizedBox(height: 20),

                        buildDropdownSection(
                          label: 'Select category',
                          value: dropDownValue1,
                          hint: 'Choose category',
                          onChanged: (val) {
                            setState(() {
                              dropDownValue1 = val;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: buildLabelField(
                                label: 'Country',
                                child: buildTextField(
                                  controller: textController2,
                                  focusNode: focusNode2,
                                  hint: 'Country',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
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

                        const SizedBox(height: 20),

                        buildLabelField(
                          label: 'Specific location',
                          child: buildTextField(
                            controller: textController4,
                            focusNode: focusNode4,
                            hint: 'Business street',
                          ),
                        ),

                        const SizedBox(height: 20),

                        buildDropdownSection2(
                          label: 'Select salary type',
                          value: dropDownValue2,
                          hint: 'Select salary',
                          onChanged: (val) {
                            setState(() {
                              dropDownValue2 = val;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Job description',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2A257C),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: textController5,
                            focusNode: focusNode5,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                              hintText: "Describe job...",
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Postedjob(
                                  jobTitle: textController1.text,
                                  country: textController2.text,
                                  city: textController3.text,
                                  description: textController5.text,
                                  location: textController4.text,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 53,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3730A3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                'Post New Job',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
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

  Widget buildLabelField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 53,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: hint,
      ),
    );
  }

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
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 53,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(hint),
              items:
                  const [
                    'Frontend',
                    'Backend',
                    'Mobile',
                    'UI/UX',
                    'DevOps',
                    'Data Analyst',
                  ].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

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
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 53,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(hint),
              items:
                  const [
                    '1000 - 2 000 EGP',
                    '2000 - 3000 EGP',
                    '3000 - 4000 EGP',
                    '4000 - 5000 EGP',
                    '5000 - 6000 EGP',
                    '6000 - 7000 EGP',
                  ].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownSectiontime({
    required String hint,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 26,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(5, 0, 0, 0),

        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey)),
          items: const ['fulltime', 'part time', 'freelance'].map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget buildDropdownSectionstate({
    required String hint,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 26,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(5, 0, 0, 0),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey)),
          items: const ['midlevel', "intern", 'junior', 'senior', "lead"].map((
            e,
          ) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget buildDropdownSectionplace({
    required String hint,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 26,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(5, 0, 0, 0),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey)),
          items: const ['onsite', "remotely"].map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: onChanged,
        ),
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
          _navItem(-0.40, -0.41, Icons.add_box_outlined, "Jobs", true, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Postnewjob()),
            );
          }),
          _navItem(0.20, 0.96, Icons.assignment, "Application", false, () {
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/account.dart';
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
          /// ================= BODY =================
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// HEADER
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

          /// ================= BOTTOM NAV =================
          Container(
            height: height * 0.09,
            color: const Color(0xFF00205B),
            child: const Center(
              child: Text(
                "Bottom Navigation",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabelField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500)),
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
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500)),
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
              items: const [
                'Frontend',
                'Backend',
                'Mobile',
                'UI/UX',
                'DevOps',
                'Data Analyst'
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
    return buildDropdownSection(
      label: label,
      hint: hint,
      value: value,
      onChanged: onChanged,
    );
  }
}

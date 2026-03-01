import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opporto_project/featuers/Company/Application.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/home.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Markkamel extends StatefulWidget {
  const Markkamel({super.key});

  @override
  State<Markkamel> createState() => _MarkkamelState();
}

class _MarkkamelState extends State<Markkamel> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                  _buildHeader(),
                  const SizedBox(height: 28),

                  _sectionTitle(),

                  const SizedBox(height: 24),
                  _infoRow("Name", "Mark Kamel"),
                  _infoRow("Email", "markkamel@gmail.com"),
                  _infoRow("Phone", "+30 1558604028"),
                  _infoRow("Address", "Maadi, Cairo, Egypt"),
                  _infoRow(
                    "Cover letter",
                    "Iam frontend developer react.js css Html js",
                    maxLines: 3,
                  ),
                  _infoRow("Status", "Under-graduate"),

                  const SizedBox(height: 24),
                  _cvSection(),

                  const SizedBox(height: 26),
                  _profileInfo(),

                  const SizedBox(height: 26),
                  _statusInfo(),

                  const SizedBox(height: 26),
                  _skillsSection(),

                  const SizedBox(height: 30),
                  _actionButtons(),
                  const SizedBox(height: 30),
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
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3730A3), Color(0xFF262170), Color(0xFF15123D)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              SizedBox(width: 6),
              Text(
                "Application",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Image.asset("assets/images/notification2.png", width: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle() {
    return Center(
      child: Container(
        height: 48,
        width: 358,
        color: const Color(0xFFCECECE),
        alignment: Alignment.center,
        child: const Text(
          "Application from job seekers",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cvSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CV", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _circleIcon("assets/images/application.png"),
                  const SizedBox(width: 12),
                  const Text(
                    "Mark Kamel.pdf",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: _circleIcon("assets/images/editpen.png", bg: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(String asset, {bool bg = false}) {
    return Container(
      width: 41,
      height: 41,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bg ? const Color.fromARGB(10, 0, 0, 0) : null,
        border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
      ),
      child: Image.asset(asset),
    );
  }

  Widget _profileInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Mark Kamel", style: TextStyle(fontSize: 16)),
          SizedBox(height: 4),
          Text("Junior Front-End Developer", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _statusInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Status", style: TextStyle(fontSize: 12)),
          SizedBox(height: 4),
          Text("Under-graduate", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _skillsSection() {
    final skills = [
      "Web design",
      "Technology",
      "Marketing",
      "Programming",
      "Web design",
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Top 5 skills", style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: skills
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 120,
                        child: Card(
                          child: Center(
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _gradientButton("passed", [
            Color(0xFFF0F8F0),
            Color(0xFFE6F5EB),
          ], Colors.green , Colors.green),
          const SizedBox(width: 12),
          _gradientButton("failed", [
            Color(0xFFFF5555),
            Color(0xFF993333),
          ], Colors.white, Colors.red),
          const SizedBox(width: 12),
          _gradientButton("on hold", [
            Color(0xFFF9F2E6),
            Color(0xFF938F88),
          ], const Color(0xFFF69800), const Color.fromARGB(255, 255, 255, 255)),
        ],
      ),
    );
  }

  Widget _gradientButton(String text, List<Color> colors, Color textColor , Color borderColor) {
    return Container(
      width: 104,
      height: 42,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border:   Border.all(color: borderColor , width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
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
          _navItem(-0.40, 0.96, Icons.add_box_outlined, "Jobs", false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Postnewjob()),
            );
          }),
          _navItem(0.20, -0.41, Icons.assignment, "Application", true, () {
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

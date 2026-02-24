import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/home.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  double get width => MediaQuery.of(context).size.width;

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
                children: [
                  _buildHeader(),
                  const SizedBox(height: 28),
                  _buildVacancy(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Application Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                onPressed: null,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Color(0xFFFF9800)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _applicationCard(
                          width,
                          "mark kamel",
                          "Junior Front-End Developer . Under-graduate",
                          "Passed",
                        ),
                        _applicationCard(
                          width,
                          "mark kamel",
                          "Junior Front-End Developer . Under-graduate",
                          "On-hold",
                        ),
                        _applicationCard(
                          width,
                          "Ahmed Bassil",
                          "Junior Front-End Developer . Graduate",
                          "failed",
                        ),
                        _applicationCard(
                          width,
                          "omar ahmed",
                          "Junior Front-End Developer . Graduate",
                          "failed",
                        ),
                        _applicationCard(
                          width,
                          "mina hany",
                          "Junior Front-End Developer . Graduate",
                          "failed",
                        ),
                        _applicationCard(
                          width,
                          "tony hany",
                          "Junior Front-End Developer . Under-graduate",
                          "failed",
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 343,
                          height: 44,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Postnewjob(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xbacd3730a3),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Continue through mail",
                              style: TextStyle(
                                color: Color(0xFF29247A),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
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

  Widget _applicationCard(
    double width,
    String name,
    String title,
    String status,
  ) {
    return SizedBox(
      width: width * 0.98,
      height: 74,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF707070),
                    ),
                  ),
                ],
              ),

              // 🔥 Status Button
              _statusButton(status),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusButton(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Passed':
        bgColor = const Color(0xFFE6F4EA);
        textColor = const Color(0xFF2E7D32);
        break;

      case 'On-hold':
        bgColor = const Color(0xFFF69800).withOpacity(0.1);
        textColor = const Color(0xFFF69800);
        break;

      case 'Failed':
      default:
        bgColor = const Color(0xFFFDECEA);
        textColor = const Color(0xFFD32F2F);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildVacancy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
                child: Image.asset("assets/images/logo1.png"),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Junior Front-End Developer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Full time . Remotely",
                    style: TextStyle(fontSize: 12, color: Color(0xFF434356)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: _circleIcon("assets/images/editpen.png", bg: true),
        ),
      ],
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

  Widget _circleIcon(String asset, {bool bg = false}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(5),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg ? const Color.fromARGB(10, 0, 0, 0) : null,
          border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
        ),
        child: Image.asset(asset),
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

import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/Company/Application.dart';
import 'package:opporto_project/featuers/Company/markkamel.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    const SizedBox(height: 21),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Posted Vacancy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildVacancy(),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Text(
                              "Applications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          _applicationCard(
                            width,
                            "mark kamel",
                            "Junior Front-End Developer . Under-graduate",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Markkamel()),
                              );
                            },
                          ),
                          _applicationCard(
                            width,
                            "Ahmed Bassil",
                            "Junior Front-End Developer . Graduate",null
                          ),
                          _applicationCard(
                            width,
                            "omar ahmed",
                            "Junior Front-End Developer . Graduate",null
                          ),
                          _applicationCard(
                            width,
                            "mina hany",
                            "Junior Front-End Developer . Graduate",null
                          ),
                          _applicationCard(
                            width,
                            "tony hany",
                            "Junior Front-End Developer . Under-graduate",null
                         
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
          const Text(
            " Welcome to Opporto",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Image.asset("assets/images/notification.png", width: 24),
        ],
      ),
    );
  }

  Widget _buildVacancy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }



  Widget _applicationCard(
  double width,
  String name,
  String title,
  VoidCallback? onArrowTap, 
) {
  return SizedBox(
    width: width * 0.98,
    height: 74,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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

          
            // if (onArrowTap != null)
              InkWell(
                onTap: onArrowTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(25, 0, 0, 0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xFF3730A3),
                  ),
                ),
              ),
          ],
        ),
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
          _navItem(-0.89, -0.41, Icons.home, "Home", true, () {}),
          _navItem(-0.40, 0.96, Icons.add_box_outlined, "Jobs", false, () {
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

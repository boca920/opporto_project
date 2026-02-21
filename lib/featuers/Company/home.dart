import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/Company/account.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' Welcome to Opporto',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),

                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                  "assets/images/notification.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 16, top: 21),
                      child: Text(
                        "Posted Vacancy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(25, 0, 0, 0),
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/logo1.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 12),

                        Column(
                          children: [
                            Text(
                              "Junior Front-End Developer",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Full time . Remotely",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF434356),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Text(
                              "Applications",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: width * 0.98,
                            height: 74,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "mark kamel",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Junior Front-End Developer . Under-graduate",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    InkWell(onTap: () {
                                      
                                    },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF3730A3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.98,
                            height: 74,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ahmed Bassil",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Junior Front-End Developer . Graduate",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    InkWell(onTap: () {
                                      
                                    },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF3730A3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.98,
                            height: 74,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "omar ahmed",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Junior Front-End Developer . Graduate",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    InkWell(onTap: () {
                                      
                                    },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF3730A3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.98,
                            height: 74,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "mina hany ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Junior Front-End Developer . Graduate",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    InkWell(onTap: () {
                                      
                                    },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF3730A3),
                                      ),
                                    ),
                                )],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.98,
                            height: 74,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "tony hany",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Junior Front-End Developer . Under-graduate",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    InkWell(onTap: () {
                                      
                                    },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(25, 0, 0, 0),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF3730A3),
                                        ),
                                      ),
                                    ),
                                  ],
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

                  Align(
                    alignment: const AlignmentDirectional(-0.40, 0.96),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Postnewjob()),
                        );
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
                              Icons.add_box_outlined,
                              color: Color.fromARGB(255, 255, 255, 255),
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

                  Align(
                    alignment: const AlignmentDirectional(0.82, 0.96),
                    child: GestureDetector(
                      onTap: () {
                        print("Profile tapped");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Account()),
                        );
                        
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

                  Align(
                    alignment: const AlignmentDirectional(-0.89, -0.41),
                    child: GestureDetector(
                      onTap: () {
                        print("Home tapped");Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.home,
                              color: Color(0xFF00205B),
                            ),
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
}

import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/Company/postnewjob.dart';

class Account extends StatelessWidget {
  const Account({super.key});

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
            Container(
              height: height * 0.91,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 44),

                    // Title
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Company Name
                    Container(
                      width: 343,
                      height: 65,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 41,
                            height: 41,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0x19000000),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(
                                'assets/images/logo1.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Company name",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF5C5C5C),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Opporto",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Industry
                    Container(
                      width: 343,
                      height: 71,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Industry",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Software development ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0x093730A3),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0x19000000),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF3B34A4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // About
                    Container(
                      width: 343,
                      // height: 171,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "About",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 343,
                            height: 144,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: const Text(
                              "We are a software development company dedicated to building reliable, scalable, and high-quality digital solutions. We partner with businesses to design, develop, and optimize software that solves real challenges, enhances efficiency, and supports long-term growth.",
                              style: TextStyle(
                                color: Color(0xFF818181),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Contact Details Section
                    Container(
                      width: 343,
                      child: Column(
                        children: [
                          // Contact details
                          Container(
                            width: 343,
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Contact details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                _contactRow(
                                  icon: Icons.phone_outlined,
                                  title: "phone number",
                                  value: "+30 1558604028",
                                  trailingIcon: Icons.edit,
                                ),

                                _contactRow(
                                  icon: Icons.email_outlined,
                                  title: "E-mail",
                                  value: "mohamed kamel@gmail.com",
                                  trailingIcon: Icons.edit,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Others
                          Container(
                            width: 343,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "others",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                _otherRow(
                                  iconWidget: Image.asset(  
                                    'assets/images/iconm.png',
                                    fit: BoxFit.contain,
                                  ),
                                  title: "Help Center",
                                ),

                                _otherRow(
                                  iconWidget: Image.asset(  
                                    'assets/images/logout.png',
                                    fit: BoxFit.contain,
                                  ),
                                  title: "Logout",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Next Button
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
                            color: Color(0xBACD3730A3),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Color(0xBACD3730A3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
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
                    alignment: const AlignmentDirectional(-0.40, 0.96),
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

                  // ================= Profile =================
                  Align(
                    alignment: const AlignmentDirectional(0.82, -0.41),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF00205B),
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

  static Widget _bottomItem(IconData icon, String title, {bool active = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 30,
          color: active ? const Color(0xFF3B34A4) : Colors.white,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          color: active ? const Color(0xFF3B34A4) : Colors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}


  static Widget _contactRow({
    required IconData icon,
    required String title,
    required String value,
    required IconData trailingIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x19000000), width: 1),
            ),
            child: Icon(icon, size: 24),
          ),
          SizedBox(
            width: 226,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0x093730A3),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x19000000), width: 1),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(trailingIcon, color: const Color(0xFF3B34A4)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _otherRow({required Widget iconWidget, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x19000000), width: 1),
            ),
            child: Center(child: iconWidget),
          ),
          SizedBox(
            width: 226,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0x093730A3),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x19000000), width: 1),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF3B34A4)),
            ),
          ),
        ],
      ),
    );
  }
}

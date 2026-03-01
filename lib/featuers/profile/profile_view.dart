import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/profile/cv_form.dart';
import 'package:provider/provider.dart';
import '../../core/provider/provider_language.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/widget/card_view.dart';
import '../../core/chat/chat_home.dart';
import '../map/map_view.dart';
import 'pdf_view.dart';

class ProfileView extends StatefulWidget {
  final String fullName;
  final String address;
  final String phone;
  final String email;

  const ProfileView({
    super.key,
    required this.fullName,
    required this.address,
    required this.phone,
    required this.email,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String fullName;
  late String address;
  late String phone;
  late String email;

  @override
  void initState() {
    super.initState();
    fullName = widget.fullName;
    address = widget.address;
    phone = widget.phone;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final selectedRoles =
        Provider.of<UserRolesProvider>(context).selectedRoles;
    final languageProvider =
    Provider.of<AppLanguageProvider>(context);

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
    backgroundColor: AppColors.whiteColor,
    body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [


        const SizedBox(height: 50),
        Center(
          child: Text(
            "My Profile",
            style: AppFonts.blackmeduim24.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: AppColors.whiteColor,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.soraprofile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // باقي الـ ListView
        SizedBox(height: 2),
        Center(
          child: Text(
            fullName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text("Top Skills", style: AppFonts.blackbold16),
        const SizedBox(height: 10),
        if (selectedRoles.isNotEmpty)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedRoles.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(selectedRoles[index]),
                  backgroundColor: AppColors.whiteColor,
                ),
              ),
            ),
          ),

        const SizedBox(height: 20),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 85,
          text: "My PDF Document",
          text2: "PDF File",
          imageLeft: AppAssets.pdf,
          imageRight: AppAssets.add,
          onTapRight: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PdfView(),
              ),
            );
          },
        ),

        SizedBox(height: height * 0.02),

        Text("Personal details", style: AppFonts.blackbold16),
        const SizedBox(height: 20),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 85,
          text: fullName,
          text2: "Full Name",
          imageLeft: AppAssets.fullname,
          imageRight: AppAssets.edit,
          onTextChanged: (newText) {
            setState(() {
              fullName = newText;
            });
          },
        ),

        SizedBox(height: height * 0.01),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 85,
          text: address,
          text2: "Address",
          imageLeft: AppAssets.address,
          imageRight: AppAssets.add,
          showCopyIcon: true,
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MapSample(),
              ),
            );

            if (result != null && result is Map) {
              setState(() {
                address = result["address"];
              });
            }
          },
        ),

        SizedBox(height: height * 0.01),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 85,
          text: phone,
          text2: "Phone Number",
          imageLeft: AppAssets.phone,
          imageRight: AppAssets.edit,
          onTextChanged: (newText) {
            setState(() {
              phone = newText;
            });
          },
        ),

        SizedBox(height: height * 0.01),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 85,
          text: email,
          text2: "Email",
          imageLeft: AppAssets.email,
          imageRight: AppAssets.edit,
          onTextChanged: (newText) {
            setState(() {
              email = newText;
            });
          },
        ),

        SizedBox(height: height * 0.02),

        Text("Other setting", style: AppFonts.blackbold16),
        const SizedBox(height: 10),

        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatHome(),
              ),
            );
          },
          child: ProfileInfoCard(
            width: 50,height: 50,
            cardWidth: 60 ,cardHeight: 70,
            text: "Help Center",
            imageLeft: AppAssets.help,
          ),
        ),

        SizedBox(height: height * 0.01),

        ProfileInfoCard(
          width: 50,height: 50,
          cardWidth: 60 ,cardHeight: 70,
          text: "Language",
          imageLeft: AppAssets.lan,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Select Language"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text("English"),
                        onTap: () {
                          languageProvider.changeLanguage("en");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Arabic"),
                        onTap: () {
                          languageProvider.changeLanguage("ar");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CVFormView(),
              ),
            );
          },
          child: ProfileInfoCard(
            width: 50,height: 50,
            cardWidth: 60 ,cardHeight: 70,
            text: "CV Template",
            imageLeft: AppAssets.help,
          ),
        ),

        SizedBox(height: height * 0.01),

        ProfileInfoCard(
          width: 50,height: 50,
          text: "Logout",
          imageLeft: AppAssets.logout,
          cardWidth: 60 ,cardHeight: 70,
        ),

        SizedBox(height: height * 0.03),
      ],
    ),
    );
  }
}
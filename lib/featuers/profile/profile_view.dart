import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/widget/card_view.dart';

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
    var height = MediaQuery.of(context).size.height;
    final selectedRoles =
        Provider.of<UserRolesProvider>(context).selectedRoles;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(height: height * 0.05),

            /// ===== Profile Image =====
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5,
                    color: AppColors.blackColor,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: SizedBox.expand(
                    child: Image.asset(
                      AppAssets.soraprofile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),


            const SizedBox(height: 15),

            /// ===== Name =====
            Center(
              child: Text(
                fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// ===== Top Skills =====
            Text("Top Skills", style: AppFonts.blackbold16),
            const SizedBox(height: 10),

            if (selectedRoles.isNotEmpty)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedRoles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(selectedRoles[index]),
                        backgroundColor: AppColors.whiteColor,
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            /// ===== PDF Section =====
            ProfileInfoCard(
              text: "My PDF Document",
              text2: "PDF File",
              imageLeft: AppAssets.pdf,
              imageRight: AppAssets.edit,
            ),

            SizedBox(height: height * 0.02),

            /// ===== Personal Details =====
            Text("Personal details", style: AppFonts.blackbold16),
            const SizedBox(height: 20),

            ProfileInfoCard(
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

            ProfileInfoCard(
              text: address,
              text2: "Address",
              imageLeft: AppAssets.address,
              imageRight: AppAssets.edit,
              onTextChanged: (newText) {
                setState(() {
                  address = newText;
                });
              },
            ),

            ProfileInfoCard(
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

            ProfileInfoCard(
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

            /// ===== Other Settings =====
            Text("Other setting", style: AppFonts.blackbold16),
            const SizedBox(height: 10),

            ProfileInfoCard(
              text: "Help Center",
              imageLeft: AppAssets.help,
            ),

            ProfileInfoCard(
              text: "Logout",
              imageLeft: AppAssets.logout,
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}

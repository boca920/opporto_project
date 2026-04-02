import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/contact_item_widget.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/profile_menu_tile.dart';
import '../../../widgets/profile_info_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Account", isBack: false,),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ProfileInfoCard(
                  child: Row(
                    children: [
                      Image.asset('assets/images/logo1.png', width: 40, height: 40),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Company name", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          Text("Opporto", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                _sectionLabel("Industry"),
                const SizedBox(height: 8),
                ProfileInfoCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Software development", style: TextStyle(fontWeight: FontWeight.w500)),
                      Icon(Icons.edit, color: Color(0xFF3730A3), size: 18),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                _sectionLabel("About"),
                const SizedBox(height: 8),
                const Text(
                  "We are a software development company dedicated to building reliable, scalable, and high-quality digital solutions...",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(0xFF818181), fontSize: 13, height: 1.5),
                ),

                const SizedBox(height: 24),
                _sectionLabel("Contact details"),
                const SizedBox(height: 8),
                const ContactItemWidget(icon: Icons.phone_outlined, title: "phone number", value: "+30 1558604028"),
                const ContactItemWidget(icon: Icons.email_outlined, title: "E-mail", value: "mohamedkamel@gmail.com"),

                const SizedBox(height: 24),
                _sectionLabel("Other setting"),
                ProfileMenuTile(title: "Help Center", icon: Icons.help_outline, onTap: () {}),
                ProfileMenuTile(title: "Logout", icon: Icons.logout, isLogout: true, onTap: () {}),

                const SizedBox(height: 32),
                _buildNextButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) => Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333)));

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF3730A3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Next", style: TextStyle(color: Color(0xFF3730A3), fontWeight: FontWeight.bold)),
      ),
    );
  }
}
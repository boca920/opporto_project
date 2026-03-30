import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/profile/cv_form.dart';
import 'package:provider/provider.dart';
import '../../core/provider/provider_language.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/widget/card_view.dart';

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
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ==================== App Bar ====================
            SliverAppBar(
              expandedHeight: height * 0.25, // ارتفاع ديناميكي
              floating: false,
              pinned: true,
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.movColor,
                        AppColors.movColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: height * 0.02),
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(AppAssets.soraprofile),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          fullName,
                          style: AppFonts.whiteSemiBold18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height * 0.005),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ==================== Content ====================
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================== Skills Section ====================
                    _buildSectionHeader("Top Skills"),
                    SizedBox(height: height * 0.01),
                    if (selectedRoles.isNotEmpty)
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedRoles.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(right: width * 0.01),
                            child: Chip(
                              label: Text(
                                selectedRoles[index],
                                style: AppFonts.whiteRegular16,
                              ),
                              backgroundColor: AppColors.movColor,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: height * 0.03),

                    // ==================== PDF Document ====================
                    _buildSectionHeader("Documents"),
                    SizedBox(height: height * 0.01),
                    _buildDocumentCard(
                      title: "My PDF Document",
                      subtitle: "PDF File",
                      icon: Icons.calendar_view_day_rounded,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PdfView(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.03),

                    _buildSectionHeader("Personal Details"),
                    SizedBox(height: height * 0.01),
                    _buildInfoCard(
                      icon: Icons.person,
                      title: "Full Name",
                      value: fullName,
                      isEditable: true,
                      onEdit: (newText) {
                        setState(() {
                          fullName = newText;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    _buildAddressCard(address),
                    SizedBox(height: height * 0.01),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: "Phone Number",
                      value: phone,
                      isEditable: true,
                      onEdit: (newText) {
                        setState(() {
                          phone = newText;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    _buildInfoCard(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: email,
                      isEditable: true,
                      onEdit: (newText) {
                        setState(() {
                          email = newText;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.03),

                    // ==================== Settings ====================
                    _buildSectionHeader("Settings"),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.help,
                      title: "Help Center",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            CVFormView(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.language,
                      title: "Language",
                      onTap: () => _showLanguageDialog(languageProvider),
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.calendar_view_day,
                      title: "CV Template",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CVFormView(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.logout,
                      title: "Logout",
                      isDestructive: true,
                      onTap: () => _showLogoutDialog(),
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== Section Header ====================
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppFonts.blackbold18,
    );
  }

  // ==================== Document Card ====================
  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.movColor, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.blackbold16,
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppFonts.grayRegular14,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.darkGrayColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Info Card ====================
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isEditable,
    required Function(String) onEdit,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: isEditable
            ? () {
          _showEditDialog(
            title: title,
            currentValue: value,
            onSaved: (newText) {
              onEdit(newText);
            },
          );
        }
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.movColor, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.grayRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      value,
                      style: AppFonts.blackbold16,
                    ),
                  ],
                ),
              ),
              if (isEditable)
                Icon(
                  Icons.edit,
                  color: AppColors.movColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Address Card ====================
  Widget _buildAddressCard(String address) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FreeMapWithSearch(),
            ),
          );
          if (result != null && result is Map) {
            setState(() {
              address = result["address"];
            });
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.location_history, color: AppColors.movColor, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: AppFonts.grayRegular14,
                    ),
                    SizedBox(height: 4),
                    Text(
                      address,
                      style: AppFonts.blackbold16,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.add,
                color: AppColors.movColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Settings Card ====================
  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.errorColor.withOpacity(0.1)
                      : AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? AppColors.errorColor : AppColors.movColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.blackbold16,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.darkGrayColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Edit Dialog ====================
  void _showEditDialog({
    required String title,
    required String currentValue,
    required Function(String) onSaved,
  }) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter $title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSaved(controller.text);
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // ==================== Language Dialog ====================
  void _showLanguageDialog(AppLanguageProvider languageProvider) {
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
  }

  // ==================== Logout Dialog ====================
  void _showLogoutDialog() {}}
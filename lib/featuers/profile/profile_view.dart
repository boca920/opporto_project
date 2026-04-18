import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opporto_project/featuers/chat/chatbot_view.dart';
import 'package:opporto_project/featuers/profile/cv_form.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import '../../core/provider/provider_language.dart';
import '../../core/provider/user_roles_provider.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import 'package:opporto_project/core/utils/ui_scale.dart';

import '../map/map_view.dart';
import 'edit_profile_view.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isNavigating = false;
  bool _initialized = false;

  String _fallback(dynamic v, String fb) {
    final s = (v ?? '').toString().trim();
    return s.isEmpty ? fb : s;
  }

  late String _fullName;
  late String _email;
  late String _phone;
  late String _role;
  late String _address;

  String? _profileImagePath;
  String? _cvPath;

  final List<Map<String, String>> _extraDocuments = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user ?? {};

    _fullName = _fallback(user['name'], 'User');
    _email = _fallback(user['email'], '—');
    _phone = _fallback(user['phone'], '—');
    _role = _fallback(user['role'], 'Flutter Developer');
    _address = _fallback(user['address'], 'San Francisco, CA');

    _initialized = true;
  }

  Future<void> _safePush(Widget page) async {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
    _isNavigating = false;
  }

  Future<void> _safePushReplacement(Widget page) async {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
    _isNavigating = false;
  }

  Future<void> _openEditProfile() async {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;

    final updated = await Navigator.push<Map<String, String?>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileView(
          fullName: _fullName,
          email: _email,
          phone: _phone,
          address: _address,
          profileImagePath: _profileImagePath,
          cvPath: _cvPath,
        ),
      ),
    );

    _isNavigating = false;
    if (!mounted || updated == null) return;

    setState(() {
      _fullName = _fallback(updated['name'], _fullName);
      _phone = _fallback(updated['phone'], _phone);
      _address = _fallback(updated['address'], _address);
      _profileImagePath = updated['profileImagePath'];
      _cvPath = updated['cvPath'];
    });
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final path = file.path ?? '';
    final name = file.name;
    if (path.isEmpty) return;

    setState(() {
      _extraDocuments.add({'name': name, 'path': path});
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Document added: $name'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _pickProfileImageFromProfile() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() {
      _profileImagePath = picked.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedRoles = Provider.of<UserRolesProvider>(context).selectedRoles;
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final height = context.h;
    final width = context.w;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                      top: height * 0.02,
                      bottom: height * 0.06,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2D2A4A), Color(0xFF1F2038)],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                            const Spacer(),
                            Text(
                              "Profile",
                              style: AppFonts.whiteSemiBold18.copyWith(fontSize: 20),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: _openEditProfile,
                              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.015),
                        GestureDetector(
                          onTap: _pickProfileImageFromProfile,
                          child: CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: (_profileImagePath != null &&
                                  _profileImagePath!.isNotEmpty)
                                  ? FileImage(File(_profileImagePath!))
                                  : AssetImage(AppAssets.soraprofile) as ImageProvider,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.012),
                        Text(
                          _fullName,
                          style: AppFonts.whiteSemiBold18.copyWith(fontSize: 28),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          _role,
                          style: AppFonts.whiteRegular16.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Personal Info"),
                    SizedBox(height: height * 0.012),
                    _buildModernInfoTile(
                      icon: Icons.person_outline,
                      title: "Full Name",
                      value: _fullName,
                    ),
                    SizedBox(height: height * 0.01),
                    _buildModernInfoTile(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: _email,
                    ),
                    SizedBox(height: height * 0.01),
                    _buildModernInfoTile(
                      icon: Icons.phone_outlined,
                      title: "Phone",
                      value: _phone,
                    ),
                    SizedBox(height: height * 0.01),
                    _buildAddressCard(_address),
                    SizedBox(height: height * 0.025),

                    _buildSectionHeader("Top Skills"),
                    SizedBox(height: height * 0.012),
                    if (selectedRoles.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedRoles
                            .map(
                              (skill) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D2A4A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              skill,
                              style: AppFonts.whiteRegular16.copyWith(fontSize: 13),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    SizedBox(height: height * 0.025),


                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.upload_file,
                      title: "Add Document",
                      onTap: _pickDocument,
                    ),
                    if (_cvPath != null && _cvPath!.isNotEmpty) ...[
                      SizedBox(height: height * 0.01),
                      _buildDocumentCard(
                        title: _cvPath!.split(Platform.pathSeparator).last,
                        subtitle: "CV File",
                        icon: Icons.description_outlined,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('CV path: $_cvPath')),
                          );
                        },
                      ),
                    ],
                    if (_extraDocuments.isNotEmpty) ...[
                      SizedBox(height: height * 0.012),
                      ..._extraDocuments.map((doc) {
                        final path = doc['path'] ?? '';
                        final name = doc['name'] ?? 'Document';
                        final ext = name.contains('.') ? name.split('.').last.toUpperCase() : 'FILE';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildDocumentCard(
                            title: name,
                            subtitle: "$ext File",
                            icon: Icons.insert_drive_file_outlined,
                            onTap: () {
                              if (!File(path).existsSync()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('File not found on device'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Document path: $path')),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                    SizedBox(height: height * 0.025),

                    _buildSectionHeader("Settings"),
                    SizedBox(height: height * 0.012),
                    _buildSettingsCard(
                      icon: Icons.help_outline,
                      title: "Help Center",
                      onTap: () => _safePush(const ChatbotView()),
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.language,
                      title: "Language",
                      onTap: () => _showLanguageDialog(languageProvider),
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.description_outlined,
                      title: "CV Template",
                      onTap: () => _safePushReplacement(CVFormView()),
                    ),
                    SizedBox(height: height * 0.01),
                    _buildSettingsCard(
                      icon: Icons.logout,
                      title: "Logout",
                      isDestructive: true,
                      onTap: _showLogoutDialog,
                    ),
                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppFonts.whiteSemiBold18.copyWith(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppFonts.whiteRegular16.copyWith(
            fontSize: 12,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AppFonts.blackbold18.copyWith(fontSize: 18));
  }

  Widget _buildModernInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.movColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.movColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppFonts.grayRegular14),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: AppFonts.blackbold16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.movColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppFonts.blackbold16),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppFonts.grayRegular14),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.darkGrayColor, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(String address) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () async {
          if (_isNavigating || !mounted) return;
          _isNavigating = true;
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FreeMapWithSearch()),
          );
          _isNavigating = false;

          if (result != null && result is Map && mounted) {
            setState(() {
              _address = (result["address"] ?? _address).toString();
            });
          }
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.movColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.location_on_outlined, color: AppColors.movColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address", style: AppFonts.grayRegular14),
                    const SizedBox(height: 3),
                    Text(address, style: AppFonts.blackbold16),
                  ],
                ),
              ),
              const Icon(Icons.edit_location_alt_outlined, color: AppColors.movColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.errorColor.withOpacity(0.1)
                      : AppColors.movColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? AppColors.errorColor : AppColors.movColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: AppFonts.blackbold16)),
              Icon(Icons.arrow_forward_ios, color: AppColors.darkGrayColor, size: 16),
            ],
          ),
        ),
      ),
    );
  }

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

  void _showLogoutDialog() {}
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/update_profile/update_profile.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/contact_item_widget.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/profile_menu_tile.dart';
import '../../../widgets/profile_info_card.dart';


class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBloc, JobState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "Error loading data")),
          );
        }
      },
      builder: (context, state) {
        final user = state.userModel;

        if (state.status == RequestStatus.loading && user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (user == null && state.status == RequestStatus.error) {
          return const Center(child: Text("No Profile Data Found"));
        }

        return Column(
          children: [
            const CustomHeader(title: "Account", isBack: false),
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
                            children: [
                              const Text("Company name", style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text(user?.name ?? "N/A", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                        children: [
                          Text(user?.industry ?? "No Industry", style: const TextStyle(fontWeight: FontWeight.w500)),
                          const Icon(Icons.edit, color: Color(0xFF3730A3), size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel("About"),
                    const SizedBox(height: 8),
                    Text(
                      user?.about ?? "No About",
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Color(0xFF818181), fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel("Contact details"),
                    const SizedBox(height: 8),
                    ContactItemWidget(
                      icon: Icons.phone_outlined,
                      title: "phone number",
                      value: user?.phone ?? "N/A",
                    ),
                    ContactItemWidget(
                      icon: Icons.email_outlined,
                      title: "E-mail",
                      value: user?.email ?? "N/A",
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel("Other setting"),
                    ProfileMenuTile(
                      title: "Help Center",
                      icon: Icons.help_outline,
                      onTap: () {},
                    ),
                    ProfileMenuTile(
                      title: "Logout",
                      icon: Icons.logout,
                      isLogout: true,
                      onTap: () {},
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          final jobBloc = context.read<JobBloc>();

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: jobBloc,
                                child: const EditProfileScreen(),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF3730A3)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Color(0xFF3730A3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/applicant_details_screen/applicant_details_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/services/api_server.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<dynamic> _myJobs = [];
  List<dynamic> _applications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _fetchMyJobs(),
      _fetchApplications(),
    ]);
  }

  Future<void> _fetchMyJobs() async {
    try {
      final jobs = await ApiService.getMyJobs();
      if (mounted) {
        setState(() {
          _myJobs = jobs;
        });
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    }
  }

  Future<void> _fetchApplications() async {
    try {
      // هنا هتحتاج endpoint جديد لجلب الطلبات، لكن دلوقتي هنستخدم mock data
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(title: "Welcome to Opporto", isBack: false),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Posted Vacancy",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                if (_myJobs.isNotEmpty)
                  ..._myJobs.take(1).map((job) => VacancyCard(
                    jobTitle: job['title'] ?? '',
                    jobType: '${job['workType']} . ${job['location']}',
                    logoPath: "assets/images/logo1.png",
                  )),
                const SizedBox(height: 20),
                const Text("Applications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                ...List.generate(4, (index) => ApplicationCard(
                  name: "Applicant ${index + 1}",
                  subtitle: "Junior Developer",
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.indigo),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ApplicantDetailsScreen(),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/applicant_details_screen/applicant_details_screen.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/application_card.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_header.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/vacancy_card.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<dynamic> _myJobs = [];
  List<dynamic> _applications = [];
  bool _isLoading = true;
  String? _token;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    await Future.wait([
      _fetchMyJobs(),
      _fetchApplications(),
    ]);
  }

  Future<void> _fetchMyJobs() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:4000/api/v1/jobs/getmyjobs'),
        headers: {'Authorization': 'Bearer $_token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _myJobs = data['myJobs'] ?? [];
          });
        }
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
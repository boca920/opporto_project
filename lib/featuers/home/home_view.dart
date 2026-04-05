import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/provider/jop_provider.dart'; // ✅ JobsProvider
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/card_view.dart';
import 'package:opporto_project/featuers/home/notification.dart';
import 'package:opporto_project/core/services/notification_service.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'dart:async';
import 'package:opporto_project/core/utils/ui_scale.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isNotifLoading = true;
  List<dynamic> _latestNotifications = [];
  Timer? _refreshTimer;
  int _lastJobsCount = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      jobsProvider.fetchAllJobs();

      _loadLatestNotifications();

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.isJobSeeker) {
        _lastJobsCount = jobsProvider.jobsCount;
        _refreshTimer?.cancel();
        _refreshTimer = Timer.periodic(const Duration(seconds: 20), (_) async {
          await jobsProvider.fetchAllJobs(forceRefresh: true);
          if (!mounted) return;
          final newCount = jobsProvider.jobsCount;
          if (newCount > _lastJobsCount) {
            final diff = newCount - _lastJobsCount;
            _lastJobsCount = newCount;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(' $diff new job(s) posted'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );

            _loadLatestNotifications();
          } else {
            _lastJobsCount = newCount;
          }
        });
      }
    });
  }

  Future<void> _loadLatestNotifications() async {
    setState(() => _isNotifLoading = true);
    try {
      final notifs = await NotificationService.getMyNotifications();
      if (!mounted) return;
      setState(() {
        _latestNotifications = notifs;
        _isNotifLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _latestNotifications = [];
        _isNotifLoading = false;
      });
    }
  }

  void _filterJobs(String query) {
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    final height = context.h;
    final width = context.w;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  prefixIconData: Icons.search_outlined,
                  controller: _searchController,
                  hintText: "Search Jobs...",
                  isPassword: false,
                  isSearch: true,
                  onSearch: _filterJobs,
                ),
              ),
              SizedBox(width: width * 0.02),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                ),
                child: Image.asset(AppAssets.notif, width: 40, height: 40),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<JobsProvider>(
          builder: (context, jobsProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let’s Find Your\nDream Job!",
                      style: AppFonts.movbold24,
                    ),
                    SizedBox(height: height * 0.02),


                    if (_isNotifLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else if (_latestNotifications.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Latest notifications',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ..._latestNotifications
                              .take(2)
                              .map((n) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6),
                                    child: Text(
                                      (n is Map<String, dynamic>
                                              ? (n['message'] ??
                                                  n['text'] ??
                                                  n['title'] ??
                                                  n['body'])
                                              : null) ??
                                          n.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                    if (_isNotifLoading == false && _latestNotifications.isEmpty)
                      const SizedBox.shrink(),


                    if (jobsProvider.isLoading)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (jobsProvider.error != null)
                      Center(
                        child: Column(
                          children: [
                            Text('Error: ${jobsProvider.error}'),
                            ElevatedButton(
                              onPressed: () => jobsProvider.fetchAllJobs(forceRefresh: true),
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Found ${jobsProvider.jobsCount} jobs",
                            style: AppFonts.blackbold16.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: height * 0.02),


                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: jobsProvider.allJobs.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final job = jobsProvider.allJobs[index];
                              return JobCard(job: job);
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}

// ✅ Widget لعرض كل وظيفة
class JobCard extends StatelessWidget {
  final dynamic job;

  const JobCard({super.key, required this.job});

  String _formatSalary(dynamic job) {
    if (job['fixedSalary'] != null) {
      return '${job['fixedSalary']} EGP';
    } else if (job['salaryFrom'] != null && job['salaryTo'] != null) {
      return '${job['salaryFrom']} - ${job['salaryTo']} EGP';
    }
    return 'Salary: Negotiable';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF3730A3),
                child: Text(
                  job['title']?[0].toUpperCase() ?? 'J',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['title'] ?? 'No Title',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${job['city'] ?? ''}, ${job['country'] ?? ''}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            job['description'] ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatSalary(job),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3730A3),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF3730A3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job['category'] ?? 'IT',
                  style: TextStyle(
                    color: Color(0xFF3730A3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
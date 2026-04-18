import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/provider/jop_provider.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/featuers/home/notification.dart';
import 'package:opporto_project/core/services/notification_service.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'dart:async';
import 'package:opporto_project/core/utils/ui_scale.dart';

import '../application/presentation/screen/application_view.dart';


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
  String? _categoryFilter;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });

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
    setState(() {});
  }

  List<dynamic> _visibleJobs(List<dynamic> all) {
    var list = List<dynamic>.from(all);
    if (_categoryFilter != null && _categoryFilter!.isNotEmpty) {
      list = list
          .where((j) => (j['category']?.toString() ?? '') == _categoryFilter)
          .toList();
    }
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return list;
    return list.where((job) {
      final title = (job['title'] ?? '').toString().toLowerCase();
      final desc = (job['description'] ?? '').toString().toLowerCase();
      final cat = (job['category'] ?? '').toString().toLowerCase();
      final city = (job['city'] ?? '').toString().toLowerCase();
      return title.contains(q) || desc.contains(q) || cat.contains(q) || city.contains(q);
    }).toList();
  }

  void _openCategoryFilter(List<dynamic> allJobs) {
    final cats = allJobs
        .map((e) => e['category']?.toString())
        .whereType<String>()
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              ListTile(
                title: const Text('All categories'),
                onTap: () {
                  setState(() => _categoryFilter = null);
                  Navigator.pop(ctx);
                },
              ),
              ...cats.map(
                    (c) => ListTile(
                  title: Text(c),
                  onTap: () {
                    setState(() => _categoryFilter = c);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _postedAgo(dynamic job) {
    final raw = job['createdAt'] ?? job['postedAt'];
    if (raw == null) return 'Recently';
    final d = DateTime.tryParse(raw.toString());
    if (d == null) return 'Recently';
    final diff = DateTime.now().difference(d).inDays;
    if (diff <= 0) return 'Today';
    return 'Posted $diff days ago';
  }

  List<String> _chips(dynamic job) {
    return [
      (job['employmentType'] ?? job['employment'] ?? 'Full-time').toString(),
      (job['experienceLevel'] ?? job['level'] ?? 'Junior').toString(),
      (job['workMode'] ?? job['workType'] ?? 'Remotely').toString(),
    ];
  }

  String _categorySubline(dynamic job) {
    final emp = (job['employmentType'] ?? job['employment'] ?? 'Full time').toString();
    final mode = (job['workMode'] ?? job['workType'] ?? 'On site').toString();
    return '$emp · $mode';
  }

  Widget _roundAction({required Widget child, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(width: 44, height: 44, child: Center(child: child)),
      ),
    );
  }

  Widget _topCompanyCard(dynamic job) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF2D2A4A), Color(0xFF4A3F8C)],
    );
    final title = (job['title'] ?? 'Job').toString();
    final city = (job['city'] ?? '').toString();
    final country = (job['country'] ?? '').toString();
    final loc = [city, country].where((e) => e.isNotEmpty).join(', ');
    final letter = title.isNotEmpty ? title[0].toUpperCase() : 'J';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ApplicationView(job: job)),
        );
      },
      child: Container(
        width: 320,

        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2A4A),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _postedAgo(job),
                  style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              loc.isEmpty ? '—' : loc,
              style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _chips(job)
                  .map(
                    (t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularRow(dynamic job) {
    final title = (job['title'] ?? 'Job').toString();
    final cat = (job['category'] ?? title).toString();
    final letter = title.isNotEmpty ? title[0].toUpperCase() : 'J';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ApplicationView(job: job)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFF2F4F7),
                  child: Text(letter, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cat, style: AppFonts.blackbold16.copyWith(fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(
                        _categorySubline(job),
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.movColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = context.h;
    final width = context.w;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Consumer<JobsProvider>(
          builder: (context, jobsProvider, child) {
            final jobs = _visibleJobs(jobsProvider.allJobs);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            prefixIconData: Icons.search_outlined,
                            controller: _searchController,
                            hintText: 'Search by Job Title',
                            isPassword: false,
                            isSearch: true,
                            onSearch: _filterJobs,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        _roundAction(
                          child: const Icon(Icons.tune, size: 20),
                          onTap: () => _openCategoryFilter(jobsProvider.allJobs),
                        ),
                        const SizedBox(width: 8),
                        _roundAction(
                          child: Image.asset(AppAssets.notif, width: 22, height: 22),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NotificationPage()),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Let’s Find Your\nDream Job!",
                      style: AppFonts.movbold24,
                    ),
                    SizedBox(height: height * 0.015),
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
                          ..._latestNotifications.take(2).map(
                                (n) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
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
                            ),
                          ),
                        ],
                      ),
                    if (_isNotifLoading == false && _latestNotifications.isEmpty)
                      const SizedBox.shrink(),
                    SizedBox(height: height * 0.02),
                    if (jobsProvider.isLoading)
                      const Center(
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
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    else ...[
                        Text(
                          'Found ${jobs.length} jobs',
                          style: AppFonts.blackbold16.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: height * 0.02),
                        Text('Top companies', style: AppFonts.blackbold18),
                        SizedBox(height: height * 0.012),
                        if (jobs.isEmpty)
                          Text('No jobs match your filters', style: TextStyle(color: Colors.grey.shade600))
                        else
                          SizedBox(
                            height: height * 0.26,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: jobs.length,
                              itemBuilder: (context, index) => _topCompanyCard(jobs[index]),
                            ),
                          ),
                        SizedBox(height: height * 0.025),
                        Text('Popular categories', style: AppFonts.blackbold18),
                        SizedBox(height: height * 0.012),
                        if (jobs.isEmpty)
                          const SizedBox.shrink()
                        else
                          Column(children: jobs.map(_popularRow).toList()),
                      ],
                    SizedBox(height: height * 0.04),
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
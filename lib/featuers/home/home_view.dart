import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opporto_project/core/provider/jop_provider.dart'; // ✅ JobsProvider
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/card_view.dart';
import 'package:opporto_project/featuers/home/notification.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ✅ جلب الوظائف من الـ API عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      jobsProvider.fetchAllJobs();
    });
  }

  void _filterJobs(String query) {
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    // يمكنك إضافة بحث محلي هنا أو استخدام API search
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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

                    // ✅ حالة التحميل
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
                          // ✅ عدد الوظائف
                          Text(
                            "Found ${jobsProvider.jobsCount} jobs",
                            style: AppFonts.blackbold16.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: height * 0.02),

                          // ✅ قائمة الوظائف الحقيقية من الـ API
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
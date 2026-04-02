import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widget/Custom_text_form_field.dart';
import '../../core/provider/jop_provider.dart';
import '../home/notification.dart';
import '../home/home_view.dart';

class AllJopsView extends StatefulWidget {
  const AllJopsView({super.key});

  @override
  State<AllJopsView> createState() => _AllJopsViewState();
 }

class _AllJopsViewState extends State<AllJopsView> {
  final TextEditingController _searchController = TextEditingController();

  void _filterCategories(String query) {

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      jobsProvider.fetchAllJobs();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  hintText: "Search Categories",
                  isPassword: false,
                  isSearch: true,
                  onSearch: _filterCategories,
                ),
              ),
              SizedBox(width: width * 0.02),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
                child: Image.asset(AppAssets.notif, width: 40, height: 40),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<JobsProvider>(
            builder: (context, jobsProvider, child) {
              if (jobsProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (jobsProvider.error != null) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Error: ${jobsProvider.error}'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => jobsProvider.fetchAllJobs(forceRefresh: true),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Found ${jobsProvider.jobsCount} jobs",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: jobsProvider.allJobs.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final job = jobsProvider.allJobs[index];
                        return JobCard(job: job);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

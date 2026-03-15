import 'package:flutter/material.dart';
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

  List<Map<String, dynamic>> _topCompanies = [];
  List<Map<String, dynamic>> _popularCategories = [];

  List<Map<String, dynamic>> _filteredPopularCategories = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromBackend();
  }

  void fetchDataFromBackend() {
    _topCompanies = [
      {
        "title": "Junior UX Designer",
        "subtitle": "New Cairo, Egypt",
        "imageLeft": AppAssets.google,
        "posted": "Posted 3 days ago",
        "tags": ["Full-time", "Junior", "Remotely"]
      },
      {
        "title": "Senior Mobile Developer",
        "subtitle": "Nasr City, Egypt",
        "imageLeft": AppAssets.amazon,
        "posted": "Posted 1 day ago",
        "tags": ["Full-time", "Senior"]
      },
      {
        "title": "Frontend Developer",
        "subtitle": "Maadi, Egypt",
        "imageLeft": AppAssets.art,
        "posted": "Posted 5 days ago",
        "tags": ["Full-time", "Remotely"]
      },
    ];

    _popularCategories = [
      {
        "title": "Artificial Intelligence",
        "subtitle": "Full time . On site",
        "imageLeft": AppAssets.google1,
        "imageRight": AppAssets.back,
      },
      {
        "title": "Mobile app development",
        "subtitle": "Part time . Remotely",
        "imageLeft": AppAssets.amazon,
        "imageRight": AppAssets.back,
      },
      {
        "title": "Front end developer",
        "subtitle": "Full time . On site",
        "imageLeft": AppAssets.art,
        "imageRight": AppAssets.back,
      },
    ];

    _filteredPopularCategories = List.from(_popularCategories);
  }

  void _filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPopularCategories = List.from(_popularCategories);
      });
    } else {
      final lowerQuery = query.toLowerCase();
      setState(() {
        _filteredPopularCategories = _popularCategories.where((item) {
          return item["title"].toLowerCase().contains(lowerQuery) ||
              item["subtitle"].toLowerCase().contains(lowerQuery);
        }).toList();
      });
    }
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
                  hintText: "Search Categories",
                  isPassword: false,
                  isSearch: true,
                  onSearch: _filterCategories,
                ),
              ),
              SizedBox(width: width * 0.02),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
                child: Image.asset(
                  AppAssets.notif,
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Let’s Find Your\nDream Job!", style: AppFonts.movbold24),
                SizedBox(height: height * 0.02),

                // Top Companies Section
                Text("Top companies", style: AppFonts.blackbold18),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.23,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _topCompanies.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: width * 0.02),
                    itemBuilder: (context, index) {
                      final company = _topCompanies[index];
                      return SizedBox(
                        width: width * 0.78,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF15123D),
                                Color(0xFF262170),
                                Color(0xFF3730A3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      company["imageLeft"],
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      company["posted"] ?? "",
                                      style: AppFonts.whiteRegular16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                company["title"],
                                style: AppFonts.whiteSemiBold18,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                company["subtitle"],
                                style: AppFonts.whiteSemiBold12,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: height * 0.03),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List<Widget>.from(
                                  (company["tags"] ?? []).map(
                                        (tag) => _buildTag(tag),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.03),

                // Popular Categories Section
                Text("Popular Categories", style: AppFonts.blackbold18),
                SizedBox(height: height * 0.03),
                if (_filteredPopularCategories.isNotEmpty)
                  Column(
                    children: _filteredPopularCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ProfileInfoCard(
                          width: 50,
                          height: 70,
                          text: category["title"],
                          subtitleStyle: AppFonts.graybold12,
                          textStyle: AppFonts.blackbold16,
                          text2: category["subtitle"],
                          imageLeft: category["imageLeft"],
                          imageRight: category["imageRight"],
                          cardWidth: width,
                          cardHeight: 90,
                          onTextChanged: (value) {},
                          onTap: () {},
                        ),
                      );
                    }).toList(),
                  )
                else
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        "No categories found",
                        style: AppFonts.blackbold18.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tag builder
Widget _buildTag(String text) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 100),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: AppFonts.whiteRegular16,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
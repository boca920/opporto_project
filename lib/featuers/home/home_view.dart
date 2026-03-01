import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/card_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  hintText: "Search by Job Title",
                  isPassword: false,
                  isSearch: true,
                  onSearch: (value) {
                    print("Searching for: $value");
                  },
                ),
              ),
              SizedBox(width: width * 0.02),
              Image.asset(AppAssets.icon, width: 40, height: 40),
              SizedBox(width: width * 0.02),
              Image.asset(AppAssets.notif, width: 40, height: 40),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let’s Find Your\nDream Job!",
                  style: AppFonts.movbold24,
                ),
                SizedBox(height: height * 0.02),
                Text("Top companies", style: AppFonts.blackbold18),
                SizedBox(height: height * 0.02),

                SizedBox(
                  height: height * 0.23,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: width * 0.02),
                    itemBuilder: (context, index) {
                      return Container(
                        width: width * 0.80,
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
                            /// Top Row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    AppAssets.google,
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: Text(
                                    "Posted 3 days ago",
                                    style: AppFonts.whiteRegular16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Text(
                              "Junior UX Designer",
                              style: AppFonts.whiteSemiBold18,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "New Cairo, Egypt",
                              style: AppFonts.whiteSemiBold12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: height*0.03),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildTag("Full-time"),
                                _buildTag("Junior"),
                                _buildTag("Remotely"),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: height * 0.03),
                Text("Popular Categories", style: AppFonts.blackbold18),
                SizedBox(height: height * 0.03),

                /// Profile Cards
                ProfileInfoCard(
                  width: 50,
                  height: 110,
                  text: "Artificial Intelligence",
                  subtitleStyle: AppFonts.graybold12,
                  textStyle: AppFonts.blackbold16,
                  text2: "Full time . On site",
                  imageLeft: AppAssets.google1,
                  imageRight: AppAssets.back,
                  cardWidth: width,
                  cardHeight: 100,
                  onTextChanged: (value) {},
                  onTap: () {},
                ),
                const SizedBox(height: 10),

                ProfileInfoCard(
                  width: 50,
                  height: 100,
                  text: "Mobile app development",
                  subtitleStyle: AppFonts.graybold12,
                  textStyle: AppFonts.blackbold16,
                  text2: "Part time . Remotely",
                  imageLeft: AppAssets.amazon,
                  imageRight: AppAssets.back,
                  cardWidth: width,
                  cardHeight: 100,
                  onTextChanged: (value) {},
                  onTap: () {},
                ),
                const SizedBox(height: 10),

                ProfileInfoCard(
                  width: 50,
                  height: 100,
                  text: "Front end developer",
                  subtitleStyle: AppFonts.graybold12,
                  textStyle: AppFonts.blackbold16,
                  text2: "Full time . On site",
                  imageLeft: AppAssets.art,
                  imageRight: AppAssets.back,
                  cardWidth: width,
                  cardHeight: 100,
                  onTextChanged: (value) {},
                  onTap: () {},
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget _buildTag(String text) {
  return Container(
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
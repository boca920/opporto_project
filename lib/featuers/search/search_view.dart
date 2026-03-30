import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widget/Custom_text_form_field.dart';
import '../home/notification.dart';

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
    );
  }
}

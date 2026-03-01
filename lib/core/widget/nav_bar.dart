import 'package:flutter/material.dart';
import '../../featuers/application/application_view.dart';
import '../../featuers/home/home_view.dart';
import '../../featuers/profile/profile_view.dart';
import '../../featuers/search/search_view.dart';
import '../utils/app_colors.dart';

class AnimatedNavBar extends StatefulWidget {
  final int initialIndex;

  const AnimatedNavBar({super.key, this.initialIndex = 0});

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar> {
  late int currentIndex;
  late final PageController controller;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    controller = PageController(initialPage: currentIndex);

    // قائمة الشاشات المرتبطة بالـ NavBar
    screens = [
      const HomeView(),
      const SearchView(),
      const ApplicationView(),
      ProfileView(fullName: '', address: '', phone: '', email: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 85,
        decoration: const BoxDecoration(
          color: AppColors.movColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(Icons.home_rounded, "Home", 0),
            _buildItem(Icons.search, "Search", 1),
            _buildItem(Icons.dashboard_customize_outlined, "Application", 2),
            _buildItem(Icons.person_outline, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(0, isSelected ? -15 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: isSelected ? 1.4 : 1.0,
                  child: Icon(
                    icon,
                    color: isSelected ? AppColors.movColor : Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 16 : 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
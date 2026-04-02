import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/tab/application_tab.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/tab/home_tab.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/tab/jobs_tab.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/tab/profile_tab.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeTab(),
    const JobsTab(),
    const ApplicationsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        items: _buildNavItems(),
      ),
    );
  }

  List<NavItem> _buildNavItems() {
    return [
      NavItem(
        icon: Icons.home_rounded,
        label: "Home",
        isActive: _currentIndex == 0,
        onTap: () => _onTabTapped(0),
      ),
      NavItem(
        icon: Icons.add_box_rounded,
        label: "JOBS",
        isActive: _currentIndex == 1,
        onTap: () => _onTabTapped(1),
      ),
      NavItem(
        icon: Icons.assignment_rounded,
        label: "Application",
        isActive: _currentIndex == 2,
        onTap: () => _onTabTapped(2),
      ),
      NavItem(
        icon: Icons.person_outline_rounded,
        label: "Profile",
        isActive: _currentIndex == 3,
        onTap: () => _onTabTapped(3),
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
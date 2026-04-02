import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/services/notification_service.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/nav_bar.dart';

class NotificationPageLegacy extends StatelessWidget {
  const NotificationPageLegacy({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,size: 20,),
          onPressed: () {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AnimatedNavBar(initialIndex: 0,),
              ),
            );
          },
        ),
        title:  Text('Notifications',style: AppFonts.blackbold18,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          children: [
            SizedBox(height:height*0.1 ,),
            Text(
              'Empty',style: AppFonts.movbold24,

            ),
            SizedBox(height: height*0.02,),
            Text("you dont have any notification at this time",style: AppFonts.blackbold16,)
          ],
        ),
      ),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = true;
  List<dynamic> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    try {
      final notifs = await NotificationService.getMyNotifications();
      if (!mounted) return;
      setState(() {
        _notifications = notifs;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      debugPrint('Fetch notifications error: $e');
    }
  }

  String _notifTitle(dynamic n) {
    if (n is Map<String, dynamic>) {
      return (n['message'] ??
              n['text'] ??
              n['title'] ??
              n['body'] ??
              'Notification')
          .toString();
    }
    return n.toString();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AnimatedNavBar(initialIndex: 0),
              ),
            );
          },
        ),
        title: Text('Notifications', style: AppFonts.blackbold18),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.1),
                      Text('Empty', style: AppFonts.movbold24),
                      SizedBox(height: height * 0.02),
                      Text(
                        "you dont have any notification at this time",
                        style: AppFonts.blackbold16,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadNotifications,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final n = _notifications[index];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          _notifTitle(n),
                          style: AppFonts.blackbold16,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
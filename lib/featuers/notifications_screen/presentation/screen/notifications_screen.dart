import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_bloc.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_event.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_state.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String? token ;
  @override
  void initState() {
    super.initState();
    token = Provider.of<UserProvider>(context, listen: false).token;
    context.read<NotificationBloc>().add(GetNotificationsEvent(token: token??""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [

          TextButton(
            onPressed: () => context.read<NotificationBloc>().add(AllReadEvent(token: token??"")),
            child: const Text("all read", style: TextStyle(color: Color(0xff3730A3))),
          )
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. حالة الخطأ (مهمة جداً عشان تعرف لو التوكن باظ)
          if (state.status == RequestStatus.error) {
            return const Center(child: Text("Error fetching notifications"));
          }

          // 3. حالة النجاح بس القائمة فاضية
          if (state.notifications.isEmpty) {
            return const Center(child: Text("No notifications yet"));
          }


          return RefreshIndicator(
            onRefresh: () async => context.read<NotificationBloc>().add(GetNotificationsEvent(token: token ?? "")),
            child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.notifications.length,
                            itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return _buildNotificationItem(notification);
                            },
                          ),
              );
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    // لو الإشعار مش مقروء بنخلي لونه أغمق شوية أو نغير Border
    bool isRead = notification.isRead ?? false;

    return GestureDetector(
      onTap: () {

        context.read<NotificationBloc>().add(ReadEvent(id: notification.id! ,token: token??""));

      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: isRead ? Colors.grey.shade300 : const Color(0xff3730a399)
          ),
          borderRadius: BorderRadius.circular(12),
          color: isRead ? Colors.white : const Color(0xffDDDCF0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.message ?? "New Notification",
                style: TextStyle(
                  color: const Color(0xff3730A3),
                  fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Color(0xff3730A3)),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(notification.createdAt),
                    style: const TextStyle(color: Color(0xff3730A3), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة بسيطة لعرض الوقت بشكل لطيف
  String _formatTime(DateTime? date) {
    if (date == null) return "Just now";
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return "${diff.inMinutes} mins ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    return "${date.day}/${date.month}";
  }
}
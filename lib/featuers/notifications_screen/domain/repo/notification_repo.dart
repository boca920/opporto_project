import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';

abstract class NotificationRepository {
  Future<NotificationResponseModel> getNotifications(String token);
  Future<void> notificationRead(String id,String token);
  Future<void> allNotificationsRead(String token);
}
import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';
import 'package:opporto_project/featuers/notifications_screen/data/source/notification_ds.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/repo/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource dataSource;
  NotificationRepositoryImpl(this.dataSource);

  @override
  Future<NotificationResponseModel> getNotifications(String token) => dataSource.getMyNotifications(token);

  @override
  Future<void> notificationRead(String id,String token) => dataSource.asRead(id,token);

  @override
  Future<void> allNotificationsRead( String token) => dataSource.allAsRead(token);
}
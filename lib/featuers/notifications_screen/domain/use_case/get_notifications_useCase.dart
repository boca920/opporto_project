import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/repo/notification_repo.dart';

class GetMyNotificationsUseCase {
  final NotificationRepository repository;
  GetMyNotificationsUseCase(this.repository);

  Future<NotificationResponseModel> call(String token) async {
    return await repository.getNotifications(token);

  }
}
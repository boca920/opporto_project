import 'package:opporto_project/featuers/notifications_screen/domain/repo/notification_repo.dart';

class AllReadUseCase {
  final NotificationRepository repository;
  AllReadUseCase(this.repository);

  Future<void> call(String token) async {
    return await repository.allNotificationsRead(token);

  }
}
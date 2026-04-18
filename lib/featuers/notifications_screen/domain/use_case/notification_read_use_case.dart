import 'package:opporto_project/featuers/notifications_screen/domain/repo/notification_repo.dart';

class NotificationReadUseCase {
  final NotificationRepository repository;
  NotificationReadUseCase(this.repository);

  Future<void> call(String id,String token) async {
    return await repository.notificationRead(id,token);


  }
}
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/notifications_screen/data/model/NotificationResponseModel.dart';

class NotificationState {
  final RequestStatus status;
  final List<NotificationModel> notifications;
  final int unreadCount;
  final String? errorMessage;

  NotificationState({
    this.status = RequestStatus.init,
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
  });

  NotificationState copyWith({
    RequestStatus? status,
    List<NotificationModel>? notifications,
    int? unreadCount,
    String? errorMessage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
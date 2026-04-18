abstract class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent {
  final String token;

  GetNotificationsEvent({required this.token});
}

class ReadEvent extends NotificationEvent {
  final String id;
  final String token;
  ReadEvent({required this.id, required this.token});
}

class AllReadEvent extends NotificationEvent {
  final String token;

  AllReadEvent({required this.token});
}
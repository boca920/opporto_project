class NotificationResponseModel {
  final bool? success;
  final List<NotificationModel>? notifications;
  final int? unreadCount;

  NotificationResponseModel({this.success, this.notifications, this.unreadCount});

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      success: json['success'],
      unreadCount: json['unreadCount'],
      notifications: json['notifications'] != null
          ? (json['notifications'] as List)
          .map((i) => NotificationModel.fromJson(i))
          .toList()
          : null,
    );
  }
}

class NotificationModel {
  final String? id;
  final String? title;
  final String? message;
  final String? type;
  final String? applicationId;
  final bool? isRead;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.applicationId,
    this.isRead,
    this.createdAt,
  });

  // ✅ إضافة الـ copyWith عشان يشتغل مع الـ Bloc بدون أخطاء
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    String? applicationId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      applicationId: applicationId ?? this.applicationId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      // سحب الـ ID سواء كان اسمه applicationId أو interviewId لمرونة أكتر
      applicationId: json['meta'] != null
          ? (json['meta']['applicationId'] ?? json['meta']['interviewId'])
          : null,
      isRead: json['isRead'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
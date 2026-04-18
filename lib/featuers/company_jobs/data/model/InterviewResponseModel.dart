class InterviewResponseModel {
  bool? success;
  List<InterviewData>? interviews; // تم التغيير من مفرد لجمع

  InterviewResponseModel({this.success, this.interviews});

  factory InterviewResponseModel.fromJson(Map<String, dynamic> json) {
    return InterviewResponseModel(
      success: json['success'],
      interviews: json['interviews'] != null
          ? (json['interviews'] as List).map((i) => InterviewData.fromJson(i)).toList()
          : null,
    );
  }
}

class InterviewData {
  ApplicationInfo? application; // تم التغيير من String لـ Object
  String? employer;
  String? candidate;
  DateTime? scheduledAt;
  String? interviewType;
  String? locationOrLink;
  String? notes;
  String? name; // ✅ ADD THIS
  String? email; // ✅ (اختياري لو محتاجه)
  String? status;
  String? sId;
  String? createdAt;

  InterviewData({
    this.application,
    this.employer,
    this.candidate,
    this.scheduledAt,
    this.interviewType,
    this.locationOrLink,
    this.name,
    this.email,
    this.notes,
    this.status,
    this.sId,
    this.createdAt,
  });

  factory InterviewData.fromJson(Map<String, dynamic> json) {
    return InterviewData(
      sId: json['_id'],
      application: json['application'] != null
          ? ApplicationInfo.fromJson(json['application'])
          : null,

      employer: json['employer'],
      candidate: json['candidate'],

      name: json['name'],
      // ✅ ADD THIS
      email: json['email'],
      // (optional)

      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'])
          : null,

      interviewType: json['interviewType'],
      locationOrLink: json['locationOrLink'],
      notes: json['notes'],
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }
}
// كلاس جديد عشان الـ application بطل يكون مجرد ID
class ApplicationInfo {
  String? id;
  String? status;

  ApplicationInfo({this.id, this.status});

  factory ApplicationInfo.fromJson(Map<String, dynamic> json) {
    return ApplicationInfo(
      id: json['id'],
      status: json['status'],
    );
  }
}
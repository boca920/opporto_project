class InterviewResponseModel {
  bool? success;
  String? message;
  InterviewData? interview;

  InterviewResponseModel({this.success, this.message, this.interview});

  factory InterviewResponseModel.fromJson(Map<String, dynamic> json) {
    return InterviewResponseModel(
      success: json['success'],
      message: json['message'],
      interview: json['interview'] != null
          ? InterviewData.fromJson(json['interview'])
          : null,
    );
  }
}

class InterviewData {
  String? application;   // ID بتاع الطلب
  String? employer;      // ID بتاع صاحب العمل
  String? candidate;     // ID بتاع المتقدم
  DateTime? scheduledAt; // ميعاد الإنترفيو
  String? interviewType;
  String? locationOrLink;
  String? notes;
  String? status;
  String? sId;           // الـ ID الخاص بالإنترفيو نفسه
  String? createdAt;
  String? updatedAt;

  InterviewData({
    this.application,
    this.employer,
    this.candidate,
    this.scheduledAt,
    this.interviewType,
    this.locationOrLink,
    this.notes,
    this.status,
    this.sId,
    this.createdAt,
    this.updatedAt,
  });

  factory InterviewData.fromJson(Map<String, dynamic> json) {
    return InterviewData(
      application: json['application']?.toString(),
      employer: json['employer']?.toString(),
      candidate: json['candidate']?.toString(),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'])
          : null,
      interviewType: json['interviewType'],
      locationOrLink: json['locationOrLink'],
      notes: json['notes'],
      status: json['status'],
      sId: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['application'] = application;
    data['employer'] = employer;
    data['candidate'] = candidate;
    data['scheduledAt'] = scheduledAt?.toIso8601String();
    data['interviewType'] = interviewType;
    data['locationOrLink'] = locationOrLink;
    data['notes'] = notes;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
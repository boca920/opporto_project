import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';

class ApplicationModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String status;
  final String coverLetter;
  final String? resumeUrl;
  final String applicantUserId;

  // نستخدم كائن واحد فقط للوظيفة
  final JobModel job;

  // مختبرات (Getters) لتسهيل الوصول للبيانات القديمة دون تغيير الكود في الـ UI
  String? get jobId => job.id;
  String get jobTitle => job.jobTitle;

  ApplicationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.coverLetter,
    this.resumeUrl,
    required this.applicantUserId,
    required this.job, // نطلب كائن الوظيفة هنا
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    String extractedJobId = '';
    String extractedJobTitle = 'General Application';

    if (json['jobID'] != null) {
      if (json['jobID'] is Map) {
        extractedJobId = json['jobID']['_id']?.toString() ?? '';
        extractedJobTitle = json['jobID']['jobTitle']?.toString() ?? 'Position Not Specified';
      } else {
        extractedJobId = json['jobID'].toString();
      }
    }

    return ApplicationModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'No Name',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      coverLetter: json['coverLetter']?.toString() ?? '',
      resumeUrl: (json['resume'] != null && json['resume'] is Map)
          ? json['resume']['url']?.toString()
          : null,
      applicantUserId: (json['applicantID'] != null && json['applicantID'] is Map)
          ? (json['applicantID']['user']?.toString() ?? '')
          : '',

      // إنشاء كائن وظيفة واحد فقط
      job: JobModel(
          id: extractedJobId,
          jobTitle: extractedJobTitle,
          category: '',
          country: '',
          city: '',
          specificLocation: '',
          jobDescription: '',
          workplaceType: '',
          jobType: '',
          experienceLevel: ''
      ),
    );
  }
}
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
  ApplicationModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? coverLetter,
    String? status,
    String? applicantUserId,
    dynamic job,
  }) {
    return ApplicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      coverLetter: coverLetter ?? this.coverLetter,
      status: status ?? this.status,
      applicantUserId: applicantUserId ?? this.applicantUserId, // تمرير القيمة الحالية
      job: job ?? this.job,                                     // تمرير القيمة الحالية
    );
  }
  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    // 1. استخراج بيانات الوظيفة بأمان (هنا المفتاح في الـ JSON هو 'job')
    String extractedJobId = '';
    String extractedJobTitle = 'Position Not Specified';

    if (json['job'] != null && json['job'] is Map) {
      extractedJobId = json['job']['_id']?.toString() ?? '';
      // في الريسبونس المفتاح اسمه 'title' مش 'jobTitle'
      extractedJobTitle = json['job']['title']?.toString() ?? 'General Application';
    }

    // 2. التعامل مع الـ Resume (Cloudinary URL)
    String? extractedResumeUrl;
    if (json['resume'] != null && json['resume'] is Map) {
      extractedResumeUrl = json['resume']['url']?.toString();
    }

    // 3. التعامل مع الـ applicantID
    String extractedApplicantUserId = '';
    if (json['applicantID'] != null && json['applicantID'] is Map) {
      extractedApplicantUserId = json['applicantID']['user']?.toString() ?? '';
    }

    return ApplicationModel(
      // السيرفر باعت 'id' مباشرة وباعت '_id' برضه، فإحنا بنأمن نفسنا
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'No Name',
      email: json['email']?.toString() ?? '',

      // 🔥 التعديل المهم: تحويل الرقم لـ String عشان ميعملش Crash
      phone: json['phone']?.toString() ?? '',

      address: json['address']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      coverLetter: json['coverLetter']?.toString() ?? '',
      resumeUrl: extractedResumeUrl,
      applicantUserId: extractedApplicantUserId,

      // بناء كائن الـ JobModel بناءً على الـ JSON المتاح
      job: JobModel(
        id: extractedJobId,
        jobTitle: extractedJobTitle,
        category: '',
        country: '',
        city: '',
        specificLocation: '',
        jobDescription: '',
        workplaceType: 'Remotely', // قيمة افتراضية عشان مش موجودة في الـ JSON
        jobType: 'Full Time',      // قيمة افتراضية
        experienceLevel: '',
      ),
    );
  }

}
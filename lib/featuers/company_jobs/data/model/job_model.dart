class JobModel {
  final String? id; // معرف الوظيفة (يأتي من السيرفر)
  final String jobTitle;
  final String category;
  final String country;
  final String city;
  final String specificLocation;
  final int? fixedSalary;
  final int? minSalary;
  final int? maxSalary;
  final String jobDescription;
  final String workplaceType; // مثل: Remotely
  final String jobType; // مثل: Full-time
  final String experienceLevel; // مثل: Junior

  JobModel({
    this.id,
    required this.jobTitle,
    required this.category,
    required this.country,
    required this.city,
    required this.specificLocation,

    this.fixedSalary,
    this.minSalary,
    this.maxSalary,

    required this.jobDescription,
    required this.workplaceType,
    required this.jobType,
    required this.experienceLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": jobTitle,
      "category": category,
      "country": country,
      "city": city,
      "location": specificLocation,

      // 🔥 هنا الحل الحقيقي
      if (fixedSalary != null) "fixedSalary": fixedSalary,
      if (minSalary != null) "minSalary": minSalary,
      if (maxSalary != null) "maxSalary": maxSalary,

      "description": jobDescription,
      "workplaceType": workplaceType,
      "jobType": jobType,
      "experienceLevel": experienceLevel,
    };
  }

  factory JobModel.fromJson(Map<String, dynamic> json) {
    // ضيف البرينت ده عشان تشوف الداتا وهي داخلة الموديل
    print("Decoding Job: ${json['title']}");

    return JobModel(
      id: json['_id'],
      jobTitle: json['title'] ?? 'No Title',
      category: json['category'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      specificLocation: json['location'] ?? '',
      fixedSalary: json['fixedSalary'],
      jobDescription: json['description'] ?? '',
      // تأكد إن المسميات دي هي اللي راجعة من السيرفر بتاعك
      workplaceType: (json['workType'] != null && json['workType'] != "")
          ? json['workType']
          : "Remote",
      jobType: (json['employmentType'] != null && json['employmentType'] != "")
          ? json['employmentType']
          : "Full-Time",
      experienceLevel: json['experience'] ?? '',
    );
  }
}
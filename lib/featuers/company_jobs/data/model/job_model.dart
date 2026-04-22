class JobModel {
  final String? id;
  final String jobTitle;
  final String category;
  final String country;
  final String city;
  final String specificLocation;
  final int? fixedSalary;
  final int? minSalary;
  final int? maxSalary;
  final String jobDescription;
  final String workplaceType;
  final String jobType;
  final String experienceLevel;

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

  JobModel copyWith({
    String? id,
    String? jobTitle,
    String? category,
    String? country,
    String? city,
    String? specificLocation,
    int? fixedSalary,
    int? minSalary,
    int? maxSalary,
    String? jobDescription,
    String? workplaceType,
    String? jobType,
    String? experienceLevel,
  }) {
    return JobModel(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      category: category ?? this.category,
      country: country ?? this.country,
      city: city ?? this.city,
      specificLocation: specificLocation ?? this.specificLocation,
      fixedSalary: fixedSalary ?? this.fixedSalary,
      minSalary: minSalary ?? this.minSalary,
      maxSalary: maxSalary ?? this.maxSalary,
      jobDescription: jobDescription ?? this.jobDescription,
      workplaceType: workplaceType ?? this.workplaceType,
      jobType: jobType ?? this.jobType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": jobTitle,
      "category": category,
      "country": country,
      "city": city,
      "location": specificLocation,
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
    return JobModel(
      id: json['_id'],
      jobTitle: json['title'] ?? 'No Title',
      category: json['category'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      specificLocation: json['location'] ?? '',
      fixedSalary: json['fixedSalary'],
      jobDescription: json['description'] ?? '',
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
class Job {
  final int id;
  final String title;
  final String company;
  final String description;
  final String requirements;
  final String location;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.requirements,
    required this.location,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      description: json['description'] ?? '',
      requirements: json['requirements'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

class Student {
  final int id;
  final String name;
  final String skills;
  final String education;
  final String experience;

  Student({
    required this.id,
    required this.name,
    required this.skills,
    required this.education,
    required this.experience,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      skills: json['skills'] ?? '',
      education: json['education'] ?? '',
      experience: json['experience'] ?? '',
    );
  }
}

class Recommendation {
  final Job job;
  final double score;
  final Map<String, dynamic> evaluation;

  Recommendation({
    required this.job,
    required this.score,
    required this.evaluation,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      job: Job.fromJson(json['job']),
      score: (json['score'] as num).toDouble(),
      evaluation: json['evaluation'] ?? {},
    );
  }
}
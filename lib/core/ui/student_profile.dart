import 'package:flutter/material.dart';

import '../model/models.dart';
import '../services/api_service.dart';

import 'recommendations_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  final int studentId;

  const StudentProfileScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {

  late Future<Student> _studentFuture;

  @override
  void initState() {
    super.initState();
    _studentFuture = _loadStudentProfile();
  }

  Future<Student> _loadStudentProfile() async {
    final apiService = ApiService();
    final profileData = await apiService.getStudentProfile(widget.studentId);
    return Student.fromJson(profileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('ملف الطالب')),
      body: FutureBuilder<Student>(
        future: _studentFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          }

          final student = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(student.name, style: const TextStyle(fontSize: 22)),

                const SizedBox(height: 10),

                Text("Skills: ${student.skills}"),
                Text("Education: ${student.education}"),
                Text("Experience: ${student.experience}"),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecommendationsScreen(studentId: student.id),
                      ),
                    );
                  },
                  child: const Text("Get Job Recommendations"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
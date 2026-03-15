import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://10.0.2.2:8000";

  Future<List<dynamic>> getRecommendations(int studentId, {int topK = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recommend/$studentId?top_k=$topK'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تحميل التوصيات');
    }
  }

  Future<Map<String, dynamic>> getAdvancedEvaluation(int studentId, {int topK = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/advanced-evaluate/$studentId?top_k=$topK'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تحميل التقييم');
    }
  }

  Future<Map<String, dynamic>> getStudentProfile(int studentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/student-profile/$studentId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تحميل ملف الطالب');
    }
  }

  Future<Map<String, dynamic>> getJobDetails(int jobId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/job-details/$jobId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تحميل تفاصيل الوظيفة');
    }
  }

  Future<Map<String, dynamic>> evaluateCV(String cvText) async {
    final response = await http.post(
      Uri.parse('$baseUrl/evaluate-cv-text'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'cv_text': cvText}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تقييم السيرة الذاتية');
    }
  }
}
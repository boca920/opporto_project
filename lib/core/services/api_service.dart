import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class CVApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Emulator
  // static const String baseUrl = 'http://192.168.1.100:8000'; // Physical

  static Future<String?> pickCVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        return await file.readAsString();
      }
    } catch (e) {
      print('File picker error: $e');
    }
    return null;
  }

  static Future<Map<String, dynamic>> evaluateCV(String cvText) async {
    final response = await http.post(
      Uri.parse('$baseUrl/evaluate-cv'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'cv_text': cvText}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('فشل في التقييم: ${response.statusCode}');
  }
}
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CVUploadScreen extends StatefulWidget {
  @override
  _CVUploadScreenState createState() => _CVUploadScreenState();
}

class _CVUploadScreenState extends State<CVUploadScreen> {
  final TextEditingController _cvController = TextEditingController();
  Map<String, dynamic>? result;
  bool isUploading = false;
  String? error;

  Future<void> _pickFile() async {
    String? cvText = await CVApiService.pickCVFile();
    if (cvText != null) {
      _cvController.text = cvText;
      setState(() => error = null);
    }
  }

  Future<void> _evaluateCV() async {
    if (_cvController.text.trim().isEmpty) {
      setState(() => error = 'أدخل نص السيرة الذاتية');
      return;
    }

    setState(() {
      isUploading = true;
      error = null;
    });

    try {
      final cvResult = await CVApiService.evaluateCV(_cvController.text);
      setState(() {
        result = cvResult;
        isUploading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقييم السيرة الذاتية AI'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {
              result = null;
              error = null;
              _cvController.clear();
            }),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CV Input Section
            Card(
              color: Colors.grey[900],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description, color: Colors.blue[400]),
                        SizedBox(width: 12),
                        Text(
                          'السيرة الذاتية',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _cvController,
                      maxLines: 10,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'الصق نص السيرة الذاتية أو ارفع ملف...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _pickFile,
                            icon: Icon(Icons.upload_file),
                            label: Text('رفع ملف'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: isUploading ? null : _evaluateCV,
                            icon: isUploading
                                ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                                : Icon(Icons.assessment),
                            label: Text(isUploading ? 'جاري التحليل...' : 'تحليل CV'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            if (error != null) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 12),
                    Expanded(child: Text(error!, style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ],

            if (result != null) ...[
              SizedBox(height: 24),
              // Results Card
              Card(
                color: Colors.green[900],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 40),
                          SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                '${result!['quality_percentage']}',
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text('جودة السيرة', style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Analysis Scores
                      Text('التحليل:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 16),
                      ..._buildScoreRows(result!['analysis']),

                      SizedBox(height: 24),
                      Text('الوظائف الموصى بها:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 12),
                      ..._buildJobRecommendations(result!['recommended_jobs']),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScoreRows(Map analysis) {
    final scores = [
      {'label': 'المهارات', 'value': analysis['skills_match']},
      {'label': 'التعليم', 'value': analysis['education_match']},
      {'label': 'الخبرة', 'value': analysis['experience_years'] / 10},
    ];

    return scores.map((score) => Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(score['label'] + ':', style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: (score['value'] ?? 0).toDouble(),
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation(Colors.yellow[400]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              '${((score['value'] ?? 0) * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildJobRecommendations(List jobs) {
    return jobs.map((job) => Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.work_outline, color: Colors.white70),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('${job['match']}% مطابقة', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    )).toList();
  }
}
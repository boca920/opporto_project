import 'package:flutter/material.dart';

import '../model/models.dart';
import '../services/api_service.dart';

import 'jop_details.dart';

class RecommendationsScreen extends StatefulWidget {
  final int studentId;

  const RecommendationsScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {

  late Future<List<Recommendation>> _recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = _loadRecommendations();
  }

  Future<List<Recommendation>> _loadRecommendations() async {
    final apiService = ApiService();

    final evaluationData =
    await apiService.getAdvancedEvaluation(widget.studentId);

    final recommendations = evaluationData['recommendations'] as List;

    return recommendations
        .map((json) => Recommendation.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Job Recommendations')),

      body: FutureBuilder<List<Recommendation>>(
        future: _recommendationsFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final recommendations = snapshot.data!;

          return ListView.builder(
            itemCount: recommendations.length,
            itemBuilder: (context, index) {

              final rec = recommendations[index];

              return Card(
                child: ListTile(
                  title: Text(rec.job.title),
                  subtitle: Text(
                      "${rec.job.company} - Score: ${rec.score.toStringAsFixed(2)}"),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            JobDetailsScreen(jobId: rec.job.id),
                      ),
                    );

                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
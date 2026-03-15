import 'package:flutter/material.dart';

import '../model/models.dart';
import '../services/api_service.dart';


class JobDetailsScreen extends StatefulWidget {
  final int jobId;

  const JobDetailsScreen({Key? key, required this.jobId}) : super(key: key);

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  late Future<Job> _jobFuture;

  @override
  void initState() {
    super.initState();
    _jobFuture = _loadJobDetails();
  }

  Future<Job> _loadJobDetails() async {

    final apiService = ApiService();
    final jobData = await apiService.getJobDetails(widget.jobId);

    return Job.fromJson(jobData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Job Details")),

      body: FutureBuilder<Job>(
        future: _jobFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final job = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(job.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Text("Company: ${job.company}"),
                Text("Location: ${job.location}"),

                const SizedBox(height: 20),

                const Text("Description",
                    style: TextStyle(fontWeight: FontWeight.bold)),

                Text(job.description),

                const SizedBox(height: 20),

                const Text("Requirements",
                    style: TextStyle(fontWeight: FontWeight.bold)),

                Text(job.requirements),

              ],
            ),
          );
        },
      ),
    );
  }
}
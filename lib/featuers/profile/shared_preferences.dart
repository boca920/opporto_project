import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opporto_project/core/services/api_server.dart';

class MyJobsPage extends StatefulWidget {
  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  List<dynamic> jobs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  Future<void> loadJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      print("No token found, please login first");
      if (mounted) setState(() => loading = false);
      return;
    }

    try {
      final myJobs = await ApiService.getMyJobs();
      if (mounted) {
        setState(() {
          jobs = myJobs;
          loading = false;
        });
      }
    } catch (e) {
      print("Exception while fetching my jobs: $e");
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Jobs")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : jobs.isEmpty
          ? Center(child: Text("No jobs found"))
          : ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return ListTile(
            title: Text(job['title'] ?? 'No Title'),
            subtitle: Text(job['description'] ?? ''),
          );
        },
      ),
    );
  }
}
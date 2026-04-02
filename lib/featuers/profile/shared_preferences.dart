import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyJobsPage extends StatefulWidget {
  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  String? token;
  List jobs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTokenAndFetchJobs();
  }

  Future<void> loadTokenAndFetchJobs() async {
    // 🔑 تحميل الـ token من SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('authToken');
    print("TOKEN = $token");
    if (token != null) {
      await fetchMyJobs();
    } else {
      print("No token found, please login first");
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchMyJobs() async {
    final String url = "http://10.0.2.2:4000/api/v1/job/getmyjobs";// تأكد endpoint صح
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // إرسال التوكن
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          jobs = data['jobs'];
          loading = false;
        });
      } else {
        print("Error: ${response.statusCode} -> ${response.body}");
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        loading = false;
      });
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
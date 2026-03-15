import 'package:flutter/foundation.dart';
// You'll need to create this too

class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
  });
}

class JobsProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;
  bool _useMockData = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get useMockData => _useMockData;

  Future<void> fetchDataFromBackend() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Replace with your actual API call
      await Future.delayed(Duration(seconds: 2));

      if (_useMockData) {
        _jobs = _getMockJobs();
      } else {
        // _jobs = await ApiService().getJobs(); // Uncomment when API is ready
        _jobs = _getMockJobs(); // Temporary mock data
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    await fetchDataFromBackend();
  }

  void toggleMockData() {
    _useMockData = !_useMockData;
    notifyListeners();
  }

  List<Job> _getMockJobs() {
    return [
      Job(id: '1', title: 'Flutter Developer', company: 'TechCorp', location: 'Remote', salary: '\$80k'),
      Job(id: '2', title: 'Backend Engineer', company: 'DataInc', location: 'NYC', salary: '\$100k'),
      Job(id: '3', title: 'UI/UX Designer', company: 'DesignHub', location: 'SF', salary: '\$90k'),
    ];
  }
}
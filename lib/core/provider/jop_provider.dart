import 'package:flutter/foundation.dart';
import 'package:opporto_project/core/services/api_server.dart';

class JobsProvider with ChangeNotifier {
  List<dynamic> _allJobs = [];
  List<dynamic> _myJobs = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get allJobs => _allJobs;
  List<dynamic> get myJobs => _myJobs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get jobsCount => _allJobs.length;
  int get myJobsCount => _myJobs.length;

  // ✅ جلب كل الوظائف للـ Job Seekers
  Future<void> fetchAllJobs({bool forceRefresh = false}) async {
    if (_allJobs.isNotEmpty && !forceRefresh) return;

    _setLoading(true);
    try {
      print('🔄 JobsProvider: Fetching ALL jobs...');
      final jobs = await ApiService.getAllJobs();
      _allJobs = jobs;
      _error = null;
      print('✅ Loaded ${_allJobs.length} ALL jobs');
    } catch (e) {
      _error = e.toString();
      print('❌ fetchAllJobs error: $e');
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // ✅ إضافة وظيفة جديدة (Employer)
  Future<bool> addJob(Map<String, dynamic> jobData) async {
    _setLoading(true);
    try {
      print('📤 Adding new job: ${jobData['title']}');
      final result = await ApiService.postJob(jobData);

      if (result['success']) {
        final newJob = result['data']; // ✅ الـ job object من الـ response

        // ✅ 1. إضافة لقائمة الشركة (My Jobs)
        _myJobs.insert(0, newJob);

        // ✅ 2. إضافة لقائمة كل الوظائف (Job Seekers)
        _allJobs.insert(0, newJob);

        print('✅ Job added! Total allJobs: ${_allJobs.length}, myJobs: ${_myJobs.length}');
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      print('❌ Add job error: $e');
      return false;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // ✅ جلب وظائف الشركة الحالية
  Future<void> fetchMyJobs() async {
    _setLoading(true);
    try {
      print('🔄 Fetching company jobs...');
      final jobs = await ApiService.getMyJobs();
      _myJobs = jobs;
      print('✅ Loaded ${_myJobs.length} company jobs');
    } catch (e) {
      _error = e.toString();
      print('❌ fetchMyJobs error: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool loading) => _isLoading = loading;
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
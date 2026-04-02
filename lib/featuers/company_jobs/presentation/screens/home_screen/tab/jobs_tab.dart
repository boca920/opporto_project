import 'dart:convert'; // ✅ إضافة المطلوبة لـ jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import '../../../../../../core/provider/jop_provider.dart';
import '../../../../../../core/provider/user_provider.dart';
import '../../../../../../core/services/api_server.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/job_form_widgets.dart';
import '../../../widgets/job_post_header.dart';
import '../../../widgets/small_dropdown..dart';


class JobsTab extends StatefulWidget {
  const JobsTab({super.key});

  @override
  State<JobsTab> createState() => _JobsTabState();
}

class _JobsTabState extends State<JobsTab> {
  // ✅ Controllers
  final titleController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  // ✅ Dropdown values
  String? timeVal, levelVal, placeVal, categoryVal, salaryVal;
  bool isLoading = false;
  String? currentBaseUrl;
  String? connectionStatus;

  // ✅ Salary ranges
  final Map<String, Map<String, dynamic>> salaryRanges = {
    '2000 - 5000 EGP': {'from': 2000, 'to': 5000},
    '5000 - 10000 EGP': {'from': 5000, 'to': 10000},
    '10000 - 20000 EGP': {'from': 10000, 'to': 20000},
    'Negotiable': {'negotiable': true},
  };

  @override
  void initState() {
    super.initState();
    _testConnection();

    // ✅ جلب وظائف الشركة عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
      jobsProvider.fetchMyJobs();
    });
  }

  // ✅ اختبار الاتصال
  Future<void> _testConnection() async {
    try {
      final result = await ApiService.testConnection();
      print('🔥 CONNECTION TEST: $result');

      setState(() {
        currentBaseUrl = result['baseUrl'];
        connectionStatus = result['success']
            ? '✅ Connected'
            : '❌ Disconnected';
      });

      if (!result['success'] && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ Connection failed: ${result['error']}'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      print('❌ Test Error: $e');
      setState(() => connectionStatus = '❌ Error');
    }
  }

  // ✅ نشر الوظيفة
  Future<void> postJob() async {
    if (!_validateForm()) return;

    setState(() => isLoading = true);
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);

    try {
      // ✅ بيانات الوظيفة حسب الـ API
      final jobData = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': categoryVal ?? 'IT',
        'country': countryController.text.trim(),
        'city': cityController.text.trim(),
        'location': locationController.text.trim(),
        'experience': levelVal ?? '1 year', // ✅ مطلوب
        // ✅ الراتب حسب الاختيار
        if (salaryVal != null && salaryVal != 'Negotiable')
          'salaryFrom': salaryRanges[salaryVal!]?['from'],
        if (salaryVal != null && salaryVal != 'Negotiable')
          'salaryTo': salaryRanges[salaryVal!]?['to'],
      };

      print('📤 Posting job: ${jsonEncode(jobData)}'); // ✅ الآن jsonEncode يعمل

      // ✅ نشر الوظيفة
      final success = await jobsProvider.addJob(jobData);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Job posted successfully! 🎉'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );

        _clearForm();

        // ✅ تحديث القوائم
        await jobsProvider.fetchMyJobs();
        await jobsProvider.fetchAllJobs(forceRefresh: true);
      } else {
        throw Exception('Failed to post job');
      }
    } catch (e) {
      print('❌ Post job error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Expanded(child: Text(e.toString())),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ✅ التحقق من صحة النموذج
  bool _validateForm() {
    final errors = <String>[];

    if (titleController.text.trim().isEmpty) errors.add('Job title');
    if (descriptionController.text.trim().isEmpty) errors.add('Description');
    if (categoryVal == null) errors.add('Category');
    if (countryController.text.trim().isEmpty) errors.add('Country');
    if (cityController.text.trim().isEmpty) errors.add('City');
    if (locationController.text.trim().isEmpty) errors.add('Location');

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill: ${errors.join(', ')}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  // ✅ مسح النموذج
  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
    countryController.clear();
    cityController.clear();
    locationController.clear();
    setState(() {
      timeVal = levelVal = placeVal = categoryVal = salaryVal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, jobsProvider, child) {
        return Column(
          children: [
            // ✅ شريط حالة الاتصال
            if (currentBaseUrl != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: connectionStatus == '✅ Connected'
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: connectionStatus == '✅ Connected'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      connectionStatus == '✅ Connected'
                          ? Icons.link
                          : Icons.link_off,
                      color: connectionStatus == '✅ Connected'
                          ? Colors.green
                          : Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            connectionStatus ?? 'Testing...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: connectionStatus == '✅ Connected'
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                          Text(
                            'Server: $currentBaseUrl',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Text('Jobs: ${jobsProvider.myJobsCount}'),
                    GestureDetector(
                      onTap: _testConnection,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.refresh, size: 18, color: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              ),

            // ✅ العنوان الرئيسي
            const CustomHeader(title: "Post New Job", isBack: false),

            // ✅ النموذج
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ معاينة الوظيفة
                    JobPostHeader(
                      title: titleController.text.isEmpty
                          ? "Enter Job Title"
                          : titleController.text,
                      location: locationController.text.isEmpty
                          ? "Enter Location"
                          : "${cityController.text.isEmpty ? '' : cityController.text}, ${countryController.text.isEmpty ? '' : countryController.text}",
                      onImageTap: () {},
                    ),
                    SizedBox(height: 24),

                    // ✅ الـ Dropdowns في صف واحد
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SmallDropdown(
                            hint: "Fulltime",
                            value: timeVal,
                            items: const ['Fulltime', 'Part-time'],
                            onChanged: (v) => setState(() => timeVal = v),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: SmallDropdown(
                            hint: "Junior",
                            value: levelVal,
                            items: const ['Junior', 'Senior', '1 year', '2+ years'],
                            onChanged: (v) => setState(() => levelVal = v),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: SmallDropdown(
                            hint: "Onsite",
                            value: placeVal,
                            items: const ['Onsite', 'Remote', 'Hybrid'],
                            onChanged: (v) => setState(() => placeVal = v),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),

                    // ✅ Job Title
                    JobFormWidgets.buildLabelField(
                      label: "Job Title *",
                      child: JobFormWidgets.buildTextField(
                        controller: titleController,
                        hint: "e.g. Flutter Developer",
                        textInputType: TextInputType.text, // ✅ مضاف
                      ),
                    ),
                    SizedBox(height: 20),

                    // ✅ Category
                    JobFormWidgets.buildLabelField(
                      label: "Category *",
                      child: JobFormWidgets.buildSimpleDropdown(
                        value: categoryVal,
                        hint: "Choose category...",
                        items: [
                          'IT', 'Frontend', 'Backend', 'Mobile', 'UI/UX',
                          'Graphics & Design', 'Data Entry', 'Marketing'
                        ],
                        onChanged: (v) => setState(() => categoryVal = v),
                      ),
                    ),
                    SizedBox(height: 20),

                    // ✅ Country & City
                    Row(
                      children: [
                        Expanded(
                          child: JobFormWidgets.buildLabelField(
                            label: "Country *",
                            child: JobFormWidgets.buildTextField(
                              controller: countryController,
                              hint: "e.g. Egypt",
                              textInputType: TextInputType.text, // ✅ مضاف
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: JobFormWidgets.buildLabelField(
                            label: "City *",
                            child: JobFormWidgets.buildTextField(
                              controller: cityController,
                              hint: "e.g. Cairo",
                              textInputType: TextInputType.text, // ✅ مضاف
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // ✅ Location
                    JobFormWidgets.buildLabelField(
                      label: "Specific Location *",
                      child: JobFormWidgets.buildTextField(
                        controller: locationController,
                        hint: "e.g. Nasr City, Cairo, Egypt",
                        textInputType: TextInputType.text, // ✅ مضاف
                      ),
                    ),
                    SizedBox(height: 20),

                    // ✅ Salary
                    JobFormWidgets.buildLabelField(
                      label: "Salary Range",
                      child: JobFormWidgets.buildSimpleDropdown(
                        value: salaryVal,
                        hint: "Select salary range",
                        items: salaryRanges.keys.toList(),
                        onChanged: (v) => setState(() => salaryVal = v),
                      ),
                    ),
                    SizedBox(height: 20),

                    // ✅ Description
                    JobFormWidgets.buildLabelField(
                      label: "Job Description *",
                      child: JobFormWidgets.buildTextField(
                        controller: descriptionController,
                        hint: "Tell us about the role, requirements...",
                        maxLines: 5,
                        textInputType: TextInputType.multiline, // ✅ مضاف
                      ),
                    ),
                    SizedBox(height: 32),

                    // ✅ زر النشر
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : postJob,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3730A3),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Posting Job...", style: TextStyle(fontSize: 16)),
                          ],
                        )
                            : Text(
                          "Post New Job",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    countryController.dispose();
    cityController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
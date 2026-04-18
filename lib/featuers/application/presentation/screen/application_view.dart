import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_bloc.dart';
import 'package:opporto_project/featuers/application/presentation/widget/apply_bottom_sheet.dart';
import 'package:opporto_project/featuers/home/notification.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApplicationView extends StatefulWidget {
  final dynamic job;

  const ApplicationView({super.key, required this.job});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  static const Color _headerNavy = Color(0xFF1F2038);
  static const Color _detailsHeading = Color(0xFF8B1A1A);

  String? _fetchedCompanyName;
  bool _isLoadingCompany = false;

  @override
  void initState() {
    super.initState();
    _getCompanyData();
  }

  Future<void> _getCompanyData() async {
    final String? employerId = widget.job['postedBy']?.toString();
    if (employerId == null) return;

    setState(() => _isLoadingCompany = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String? myToken = userProvider.token;

      final response = await http.get(
        Uri.parse('https://job-backend-mj9t.vercel.app/api/v1/user/$employerId'),
        headers: {
          'Cookie': 'token=$myToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _fetchedCompanyName =
              data['user']?['name'] ?? data['name'] ?? "Company Name";
        });
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoadingCompany = false);
    }
  }

  String _t(dynamic v, [String fb = '—']) {
    final s = (v ?? '').toString().trim();
    return s.isEmpty ? fb : s;
  }

  String _formatSalary() {
    if (widget.job['fixedSalary'] != null) {
      return '${widget.job['fixedSalary']} EGP';
    }
    if (widget.job['salaryFrom'] != null &&
        widget.job['salaryTo'] != null) {
      return '${widget.job['salaryFrom']} - ${widget.job['salaryTo']} EGP';
    }
    return 'Negotiable';
  }

  String _postedOn() {
    final raw = widget.job['createdAt'] ??
        widget.job['jobPostedOn'] ??
        widget.job['postedAt'];
    if (raw == null) return '—';
    final d = DateTime.tryParse(raw.toString());
    if (d != null) {
      return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
    }
    return raw.toString();
  }

  List<Widget> _tags() {
    final chips = <String>[
      _t(widget.job['employmentType'] ?? widget.job['employment'], ''),
      _t(widget.job['experienceLevel'] ?? widget.job['level'], ''),
      _t(widget.job['workMode'] ??
          widget.job['workType'] ??
          widget.job['remoteType'], ''),
    ].where((e) => e.isNotEmpty && e != '—').toList();

    return chips
        .map((t) => Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(t, style: const TextStyle(fontSize: 12)),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final title = _t(widget.job['title'], 'Job');
    final city = _t(widget.job['city'], '');
    final country = _t(widget.job['country'], '');
    final locationLine =
    [city, country].where((e) => e.isNotEmpty).join(', ');
    final initial =
    (title.isNotEmpty ? title[0] : 'J').toUpperCase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _headerNavy,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                        const Color(0xFFE8F0FE),
                        child: Text(
                          initial,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _headerNavy),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppFonts.blackbold18
                                  .copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              locationLine.isEmpty
                                  ? '—'
                                  : locationLine,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _tags()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Job details',
                    style: AppFonts.blackbold18.copyWith(
                        color: _detailsHeading, fontSize: 18),
                  ),
                  if (_isLoadingCompany)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                              strokeWidth: 2)),
                    )
                  else if (_fetchedCompanyName != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _fetchedCompanyName!,
                      style: AppFonts.blackbold16.copyWith(
                          color: _detailsHeading,
                          fontSize: 16),
                    ),
                  ],
                  const SizedBox(height: 12),
                  _kv('title', _t(widget.job['title'])),
                  _kv('category', _t(widget.job['category'])),
                  _kv('country', _t(widget.job['country'])),
                  _kv('city', _t(widget.job['city'])),
                  _kv('location',
                      _t(widget.job['address'] ?? widget.job['location'])),
                  _kv('salary', _formatSalary()),
                  _kv('job posted on', _postedOn()),
                  const SizedBox(height: 20),
                  Text('description:',
                      style: AppFonts.blackbold16),
                  const SizedBox(height: 8),
                  Text(
                    _t(widget.job['description'],
                        'No description.'),
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () async {
            final bloc =
            BlocProvider.of<ApplicationBloc>(context);

            final result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: ApplyBottomSheet(job: widget.job),
              ),
            );

            if (result == true && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم التقديم بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _headerNavy,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28)),
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              const Text('Apply Now',
                  style:
                  TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle),
                child: const Icon(Icons.chevron_right,
                    size: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kv(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14,
              height: 1.4),
          children: [
            TextSpan(
                text: '$label: ',
                style: const TextStyle(
                    fontWeight: FontWeight.w700)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
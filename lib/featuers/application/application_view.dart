import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/home/notification.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class ApplicationView extends StatelessWidget {
  final dynamic job;

  const ApplicationView({super.key, required this.job});

  static const Color _headerNavy = Color(0xFF1F2038);
  static const Color _detailsHeading = Color(0xFF8B1A1A);

  String _t(dynamic v, [String fb = '—']) {
    final s = (v ?? '').toString().trim();
    return s.isEmpty ? fb : s;
  }

  String _formatSalary() {
    if (job['fixedSalary'] != null) return '${job['fixedSalary']} EGP';
    if (job['salaryFrom'] != null && job['salaryTo'] != null) {
      return '${job['salaryFrom']} - ${job['salaryTo']} EGP';
    }
    return 'Negotiable';
  }

  String _postedOn() {
    final raw = job['createdAt'] ?? job['jobPostedOn'] ?? job['postedAt'];
    if (raw == null) return '—';
    final d = DateTime.tryParse(raw.toString());
    if (d != null) {
      return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
    }
    return raw.toString();
  }

  List<Widget> _tags() {
    final chips = <String>[
      _t(job['employmentType'] ?? job['employment'], ''),
      _t(job['experienceLevel'] ?? job['level'], ''),
      _t(job['workMode'] ?? job['workType'] ?? job['remoteType'], ''),
    ].where((e) => e.isNotEmpty && e != '—').toList();

    return chips
        .map(
          (t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(t, style: const TextStyle(fontSize: 12)),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final title = _t(job['title'], 'Job');
    final city = _t(job['city'], '');
    final country = _t(job['country'], '');
    final locationLine = [city, country].where((e) => e.isNotEmpty).join(', ');
    final initial = (title.isNotEmpty ? title[0] : 'J').toUpperCase();

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: const Color(0xFFE8F0FE),
                        child: Text(
                          initial,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2038),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppFonts.blackbold18.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              locationLine.isEmpty ? '—' : locationLine,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Wrap(spacing: 8, runSpacing: 8, children: _tags()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Job details',
                    style: AppFonts.blackbold18.copyWith(
                      color: _detailsHeading,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _kv('title', _t(job['title'])),
                  _kv('category', _t(job['category'])),
                  _kv('country', _t(job['country'])),
                  _kv('city', _t(job['city'])),
                  _kv('location', _t(job['address'] ?? job['location'])),
                  _kv('salary', _formatSalary()),
                  _kv('job posted on', _postedOn()),
                  const SizedBox(height: 20),
                  Text('description:', style: AppFonts.blackbold16),
                  const SizedBox(height: 8),
                  Text(
                    _t(job['description'], 'No description.'),
                    style: TextStyle(color: Colors.grey.shade800, height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // اربط هنا مسار التقديم الحقيقي عندك
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Apply — wire your flow here')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _headerNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Apply Now', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_right, size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kv(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.grey.shade800, fontSize: 14, height: 1.4),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jobs UI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5E60CE)),
        useMaterial3: true,
      ),
      home: const JobsScreen(),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String location;
  final String desc;
  final String experience;
  final String employment;
  final String workType;
  final String salary;
  final String responsibilities;
  final String requirements;

  const Job({
    required this.title,
    required this.company,
    required this.location,
    required this.desc,
    required this.experience,
    required this.employment,
    required this.workType,
    required this.salary,
    required this.responsibilities,
    required this.requirements,
  });
}

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const List<Job> _allJobs = [
    Job(
      title: "Front End Developer",
      company: "Google",
      location: "Cairo, Egypt",
      desc: "We are looking for a talented front end developer.",
      experience: "Junior",
      employment: "Full-time",
      workType: "Remote",
      salary: "5k-10k",
      responsibilities: "Build responsive UI, optimize performance, collaborate with designers.",
      requirements: "Flutter basics, state management, clean code principles.",
    ),
    Job(
      title: "UI/UX Engineer",
      company: "Microsoft",
      location: "California, USA",
      desc: "Our company is looking for a professional UI/UX Designer.",
      experience: "Mid",
      employment: "Full-time",
      workType: "Hybrid",
      salary: "10k-20k",
      responsibilities: "Create user flows, wireframes, and interactive prototypes.",
      requirements: "Figma, design systems, usability testing.",
    ),
    Job(
      title: "Lead UI/UX Designer",
      company: "Amazon",
      location: "California, USA",
      desc: "Our company is looking for a professional UI/UX Designer.",
      experience: "Senior",
      employment: "Full-time",
      workType: "On-site",
      salary: "20k+",
      responsibilities: "Lead design strategy, mentor team, align UX with product goals.",
      requirements: "Leadership skills, strong portfolio, cross-functional collaboration.",
    ),
    Job(
      title: "Senior UI/UX Designer",
      company: "Amazon",
      location: "California, USA",
      desc: "Our company is looking for a professional UI/UX Designer.",
      experience: "Senior",
      employment: "Part-time",
      workType: "Remote",
      salary: "10k-20k",
      responsibilities: "Deliver high-fidelity designs and maintain consistency.",
      requirements: "Advanced Figma, component libraries, accessibility standards.",
    ),
  ];

  String _selectedWorkType = "Any";
  String _selectedEmployment = "Any";
  String _selectedExperience = "Any";
  String _selectedSalary = "Any";

  final List<String> _workTypeOptions = const ["Any", "Remote", "On-site", "Hybrid"];
  final List<String> _employmentOptions = const ["Any", "Full-time", "Part-time"];
  final List<String> _experienceOptions = const ["Any", "Junior", "Mid", "Senior"];
  final List<String> _salaryOptions = const ["Any", "5k-10k", "10k-20k", "20k+"];

  List<Job> get _filteredJobs {
    final query = _searchController.text.trim().toLowerCase();

    return _allJobs.where((job) {
      final matchesSearch = query.isEmpty ||
          job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query) ||
          job.desc.toLowerCase().contains(query);

      final matchesWorkType = _selectedWorkType == "Any" || job.workType == _selectedWorkType;
      final matchesEmployment = _selectedEmployment == "Any" || job.employment == _selectedEmployment;
      final matchesExperience = _selectedExperience == "Any" || job.experience == _selectedExperience;
      final matchesSalary = _selectedSalary == "Any" || job.salary == _selectedSalary;

      return matchesSearch &&
          matchesWorkType &&
          matchesEmployment &&
          matchesExperience &&
          matchesSalary;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _filteredJobs;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by Job Title',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          onPressed: () => _searchController.clear(),
                          icon: const Icon(Icons.close),
                        )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _iconBtn(Icons.tune),
                  const SizedBox(width: 8),
                  _iconBtn(Icons.notifications_none),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _FilterDropdown(
                      label: 'Work Type',
                      value: _selectedWorkType,
                      items: _workTypeOptions,
                      onChanged: (v) => setState(() => _selectedWorkType = v!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FilterDropdown(
                      label: 'Employment',
                      value: _selectedEmployment,
                      items: _employmentOptions,
                      onChanged: (v) => setState(() => _selectedEmployment = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _FilterDropdown(
                      label: 'Experience',
                      value: _selectedExperience,
                      items: _experienceOptions,
                      onChanged: (v) => setState(() => _selectedExperience = v!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FilterDropdown(
                      label: 'Salary',
                      value: _selectedSalary,
                      items: _salaryOptions,
                      onChanged: (v) => setState(() => _selectedSalary = v!),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${jobs.length} Results',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedWorkType = "Any";
                        _selectedEmployment = "Any";
                        _selectedExperience = "Any";
                        _selectedSalary = "Any";
                        _searchController.clear();
                      });
                    },
                    child: const Text('Clear all'),
                  ),
                ],
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: jobs.isEmpty
                      ? const Center(
                    key: ValueKey('empty'),
                    child: Text('No jobs found'),
                  )
                      : ListView.builder(
                    key: const ValueKey('list'),
                    itemCount: jobs.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: JobCard(
                        job: jobs[i],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => JobDetailsScreen(job: jobs[i]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDFD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          hint: Text(label),
          items: items
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, overflow: TextOverflow.ellipsis),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFFF2F4F7),
                  child: Text(
                    job.company.substring(0, 1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text(
                        job.company,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border, size: 16),
                  label: const Text('Save'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(job.desc, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade700),
                const SizedBox(width: 4),
                Text(job.location, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _tag(job.experience),
                _tag(job.employment),
                _tag(job.workType),
                _tag(job.salary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }
}

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(job.company, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(job.location, style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _tag(job.experience),
              _tag(job.employment),
              _tag(job.workType),
              _tag(job.salary),
            ],
          ),

          const SizedBox(height: 20),
          _sectionTitle('Job Description'),
          Text(job.desc),
          const SizedBox(height: 16),

          _sectionTitle('Responsibilities'),
          Text(job.responsibilities),
          const SizedBox(height: 16),

          _sectionTitle('Requirements'),
          Text(job.requirements),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {},
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
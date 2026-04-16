import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/screens/home_screen/home_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/featuers/company_jobs/data/model/application_model.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_bloc.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_event.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_submit_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/interview_type_selector.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/time_slot_picker.dart';



class CalendarScreen extends StatefulWidget {
  static const String routeName = 'calendar_screen';
  final ApplicationModel application;
  const CalendarScreen({super.key, required this.application});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  String _selectedType = "Online"; // هندلة نوع المقابلة

  final List<String> _timeSlots = [
    "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM",
    "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Interview Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state.status == RequestStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Interview Scheduled Successfully!"), backgroundColor: Colors.green),
            );

            // الهندلة اللي طلبتها: يوديك للهوم على صفحة الكليندر (Tab index 2)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            );
          } else if (state.status == RequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Failed to schedule"), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  // منع اختيار أيام سابقة
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() { _selectedDay = selectedDay; _focusedDay = focusedDay; });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(color: Color(0xFFF97316), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  ),
                ),
                const SizedBox(height: 24),
                _sectionTitle("Choose time"),
                const SizedBox(height: 16),
                TimeSlotPicker(
                  times: _timeSlots,
                  selectedTime: _selectedTime,
                  onTimeSelected: (time) => setState(() => _selectedTime = time),
                ),
                const SizedBox(height: 32),
                InterviewTypeSelector(
                    currentType: _selectedType,
                  onTap: () { // 👈 دالة فاضية (VoidCallback)
                    // هنا لازم تحدد النوع يدوي أو تعدل الـ Widget
                    setState(() => _selectedType = "Online");
                  },
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomSubmitButton(
                    title: state.status == RequestStatus.loading ? "Submitting..." : "Submit",
                    onTap: state.status == RequestStatus.loading ? () {} : () => _submitData(context),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitData(BuildContext context) {
    if (_selectedDay == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
      return;
    }

    // دمج التاريخ والوقت في String واحد للسيرفر
    // السيرفر مستني مسمى scheduledAt في الـ Model
    final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);
    final String fullScheduledAt = "$formattedDate $_selectedTime";

    context.read<JobBloc>().add(
      ScheduleInterviewEvent(
        applicationId: widget.application.id ?? "",
        token: context.read<UserProvider>().token ?? "",
        scheduledAt: fullScheduledAt, // ربط مع الـ Model
        interviewType: _selectedType,
        locationOrLink: _selectedType == "Online" ? "Google Meet Link" : "Company Office",
        notes: "Scheduled via Opporto App",
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(alignment: Alignment.centerLeft,
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}
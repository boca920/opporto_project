import 'package:flutter/material.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/custom_submit_button.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/interview_type_selector.dart';
import 'package:opporto_project/featuers/company_jobs/presentation/widgets/time_slot_picker.dart';import 'package:table_calendar/table_calendar.dart';

import '../notifications_screen/notifications_screen.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = 'calendar_screen';

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
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
            InterviewTypeSelector(currentType: "Online", onTap: () {}),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSubmitButton(
                title: "Submit",
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Last()));
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlotPicker extends StatelessWidget {
  final List<String> times;
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const TimeSlotPicker({
    super.key,
    required this.times,
    this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: times.map((time) {
        final bool isSelected = selectedTime == time;
        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            width: 103,
            height: 37,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0x1AF97316) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? const Color(0xFFF97316) : const Color(0xFF5A5A72),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              time,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isSelected ? const Color(0xFFF97316) : const Color(0xFF5A5A72),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
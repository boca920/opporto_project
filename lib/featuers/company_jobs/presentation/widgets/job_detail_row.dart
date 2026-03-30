import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailRow extends StatelessWidget {
  final String title;
  final String value;

  const JobDetailRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1D177A),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
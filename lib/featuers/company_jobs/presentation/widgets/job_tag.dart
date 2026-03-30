import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobTag extends StatelessWidget {
  final String text;
  const JobTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x0D000000),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: const Color(0x19000000), width: 1.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xbacd4b4b4b),
        ),
      ),
    );
  }
}
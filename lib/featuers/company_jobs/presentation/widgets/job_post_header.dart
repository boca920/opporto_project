import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPostHeader extends StatelessWidget {
  final String title;
  final String location;
  final VoidCallback onImageTap;

  const JobPostHeader({
    super.key,
    required this.title,
    required this.location,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onImageTap,
            child: Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: const Color(0xFFC5C5C5), borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Container(
                  width: 41, height: 41,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF767676)),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
              Text(location, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
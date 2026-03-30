import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final VoidCallback onTap;

  const GradientButton({
    super.key,
    required this.text,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return     InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: screenWidth*0.2,
        height: 42.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: [0.0, 1.0],
            begin: AlignmentDirectional(0.0, -1.0),
            end: AlignmentDirectional(0, 1.0),
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String? selectedFileName;


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

    );
  }
}
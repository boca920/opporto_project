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
  String? selectedFileName; // هنا نخزن اسم الملف


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text("Profile", style: AppFonts.blackmeduim24),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Text("Upload cv.", style: AppFonts.blackmeduim24),
            SizedBox(height: height * 0.03),
            InkWell(
              onTap: (){},
              child: DottedBorder(
                color: AppColors.darkGrayColor,
                strokeWidth: 2,
                dashPattern: [6, 6],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: Container(
                  height: height * 0.18,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file_rounded,
                        size: 40,
                        color: Colors.black54,
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        selectedFileName ?? "upload here",
                        style: AppFonts.blackmeduim24.copyWith(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
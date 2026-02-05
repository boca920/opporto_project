import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String selectedValue = 'Unknown';

  final List<String> menu = [
    'Unknown',
    'Company',
    'User',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(CupertinoIcons.person, size: 30, color: AppColors.movColor),
            ),
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18,
          ),
          items: menu.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
        ),
      ),
    );
  }
}

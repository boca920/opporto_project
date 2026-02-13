import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class CustomDropDownButton extends StatefulWidget {
  final Function(String?)? onChangedValue; // Callback لإرسال القيمة للصفحة

  const CustomDropDownButton({super.key, this.onChangedValue});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? selectedValue;

  final List<String> menu = [
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
          hint: const Text(
            'Select type',
            style: TextStyle(fontSize: 20),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                CupertinoIcons.person,
                size: 30,
                color: AppColors.movColor,
              ),
            ),
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18,
          ),
          items: menu.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });

            // إرسال القيمة للصفحة اللي فيها الزر
            if (widget.onChangedValue != null) {
              widget.onChangedValue!(value);
            }
          },
        ),
      ),
    );
  }
}
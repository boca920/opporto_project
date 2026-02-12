import 'package:flutter/material.dart';

class SelectableChipsExample extends StatefulWidget {
  const SelectableChipsExample({super.key});

  @override
  State<SelectableChipsExample> createState() =>
      _SelectableChipsExampleState();
}

class _SelectableChipsExampleState extends State<SelectableChipsExample> {
  List<String> categories = [
    "UI / UX",
    "Technology",
    "Interfaces",
    "Programming",
    "Web design",
    "Art & illustration",
    "Marketing"
  ];

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = selectedCategories.contains(category);

            return FilterChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              selected: isSelected,
              showCheckmark: true, // علامة الصح تظهر عند الاختيار
              selectedColor: const Color(0xff4A3AFF),
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              labelPadding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 16), // حجم ثابت للبوكس
              visualDensity: const VisualDensity(
                  horizontal: 0, vertical: 0), // يخلي الحجم ثابت
              onSelected: (value) {
                setState(() {
                  if (value) {
                    selectedCategories.add(category);
                  } else {
                    selectedCategories.remove(category);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

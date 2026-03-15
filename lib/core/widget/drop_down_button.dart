import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/l10n/app_localizations.dart';

class CustomDropDownButton<T> extends StatefulWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final bool isExpanded;
  final IconData? icon;
  final Color? dropdownColor;
  final TextStyle? style;

  const CustomDropDownButton({
    super.key,
    this.value,
    required this.hint,
    this.items,
    this.onChanged,
    this.isExpanded = true,
    this.icon = Icons.arrow_drop_down,
    this.dropdownColor,
    this.style,
  });

  @override
  State<CustomDropDownButton<T>> createState() => _CustomDropDownButtonState<T>();
}

class _CustomDropDownButtonState<T> extends State<CustomDropDownButton<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomDropDownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveItems = widget.items ?? _buildDefaultItems(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.movColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _selectedValue,
          hint: Text(
            widget.hint,
            style: AppFonts.greymeduim16.copyWith(
              color: AppColors.movColor.withOpacity(0.6),
            ),
          ),
          isExpanded: widget.isExpanded,
          icon: Icon(
            widget.icon,
            color: AppColors.movColor,
          ),
          dropdownColor: widget.dropdownColor ?? Colors.white,
          style: widget.style ?? AppFonts.blackbold16,
          items: effectiveItems,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }

  // ✅ Default items for backward compatibility
  List<DropdownMenuItem<T>> _buildDefaultItems(BuildContext context) {
    return [
      DropdownMenuItem<T>(
        value: 'Job Seeker' as T,
        child: Text(
          'Job Seeker',
          style: AppFonts.blackbold16,
        ),
      ),
      DropdownMenuItem<T>(
        value: 'Employer' as T,
        child: Text(
          'Employer',
          style: AppFonts.blackbold16,
        ),
      ),
    ];
  }
}
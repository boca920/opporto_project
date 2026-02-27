import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final IconData? prefixIconData;
  final Widget? prefixIconWidget; // ✅ أيقونة أو صورة مخصصة على اليسار
  final bool isActive;
  final TextEditingController controller;
  final bool isSearch; // لتفعيل البحث أثناء الكتابة
  final Function(String)? onSearch; // callback عند الكتابة
  final bool Function(String?)? validator; // اختياري

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIconData,
    this.prefixIconWidget,
    this.isActive = false,
    this.isPassword = false,
    this.isSearch = false,
    required this.controller,
    this.onSearch,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      cursorWidth: 2,
      onChanged: widget.isSearch ? widget.onSearch : null,
      validator: (v) {
        if (widget.validator != null) {
          return widget.validator!(v) ? null : "Invalid input";
        }
        if (!widget.isSearch && (v == null || v.isEmpty)) {
          return "Please enter ${widget.hintText}";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        fillColor: AppColors.whiteColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),


        prefixIcon: widget.prefixIconWidget ??
            (widget.prefixIconData != null
                ? Icon(widget.prefixIconData, color: AppColors.movColor, size: 24)
                : null),


        suffixIcon: widget.isPassword
            ? GestureDetector(
          onTap: _togglePassword,
          child: Icon(
            _obscureText ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
            color: AppColors.darkGrayColor,
          ),
        )
            : null,

        enabledBorder: builtDecorationBorder(),
        focusedBorder: builtDecorationBorder(),
        errorBorder: builtDecorationBorder(Colors.red),
        focusedErrorBorder: builtDecorationBorder(Colors.red),
      ),
    );
  }
}

OutlineInputBorder builtDecorationBorder([Color? borderColor]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: borderColor ?? AppColors.darkGrayColor,
      width: 1.5,
    ),
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Widget? suffixIcon;
  final bool enabled;
  final IconData? prefixIconData;
  final Widget? prefixIconWidget;
  final bool isActive;
  final bool isPassword;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final TextEditingController controller;
  final bool isSearch;
  final Function(String)? onSearch;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;        // ✅ إضافة FocusNode
  final TextInputAction? textInputAction; // ✅ إضافة textInputAction
  final Function(String)? onFieldSubmitted; // ✅ إضافة onFieldSubmitted

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.textAlign,
    this.suffixIcon,
    this.prefixIconData,
    this.prefixIconWidget,
    this.isActive = false,
    this.isPassword = false,
    this.isSearch = false,
    this.enabled = true,
    this.hintTextStyle,
    this.labelStyle,
    required this.controller,
    this.onSearch,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
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
      focusNode: widget.focusNode,           // ✅ FocusNode support
      textInputAction: widget.textInputAction, // ✅ Keyboard action
      onFieldSubmitted: widget.onFieldSubmitted, // ✅ Submit callback
      validator: widget.validator,           // ✅ Validator للـ Form validation
      keyboardType: widget.keyboardType,     // ✅ Keyboard type
      textAlign: widget.textAlign ?? TextAlign.start,

      obscureText: _obscureText,
      cursorWidth: 2,
      onChanged: widget.isSearch ? widget.onSearch : null,

      // ✅ Autovalidate عشان الـ validation يشتغل فوراً
      autovalidateMode: AutovalidateMode.onUserInteraction,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle ?? AppFonts.grayRegular14,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? AppFonts.blackbold16,

        fillColor: AppColors.whiteColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        // ✅ Prefix Icon
        prefixIcon: widget.prefixIconWidget ??
            (widget.prefixIconData != null
                ? Icon(
              widget.prefixIconData,
              color: AppColors.movColor,
              size: 24,
            )
                : null),

        // ✅ Suffix Icon (Password toggle أو custom)
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? GestureDetector(
              onTap: _togglePassword,
              child: Icon(
                _obscureText
                    ? CupertinoIcons.eye_slash_fill
                    : CupertinoIcons.eye_fill,
                color: AppColors.darkGrayColor,
              ),
            )
                : null),

        // ✅ Border States
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkGrayColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.movColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2.5),
        ),

        // ✅ Error Style محسن
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),

        // ✅ Disabled state
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
      ),
    );
  }
}
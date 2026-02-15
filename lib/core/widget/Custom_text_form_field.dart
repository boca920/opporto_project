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
  final bool isActive;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIconData,
    this.isActive = false,
    required this.isPassword,
    required this.controller,
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

      validator: (v) {
        if (v == null || v.isEmpty) {
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

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),

        prefixIcon: widget.prefixIconData != null
            ? Icon(
          widget.prefixIconData,
          color: AppColors.movColor,
          size: 24,
        )
            : null,

        /// 👁 Password Toggle
        suffixIcon: widget.isPassword
            ? GestureDetector(
          onTap: _togglePassword,
          child: Icon(
            _obscureText
                ? CupertinoIcons.eye_slash_fill
                : CupertinoIcons.eye_fill,
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

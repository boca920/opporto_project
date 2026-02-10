import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextStyle? hintTextStyle;
  final TextStyle? labelStyle;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final bool isActive;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIconData,
    this.suffixIconData, this.isActive=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        labelText: labelText,
        labelStyle: labelStyle,

        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),


        prefixIcon: prefixIconData != null
            ? Icon(
          prefixIconData,
          color: isActive
              ? AppColors.movColor
              : AppColors.darkGrayColor,
          size: 30,
        )
            : null,

        suffixIcon:
        suffixIconData !=null?Icon(suffixIconData,color: AppColors.darkGrayColor,size: 30,):null ,

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
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: borderColor ?? AppColors.darkGrayColor,
      width: 1.3,
    ),
  );
}

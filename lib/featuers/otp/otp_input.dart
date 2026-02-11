import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpInput extends StatelessWidget {
  final Function(String) onCompleted;

  const OtpInput({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Color(0xff1E3C57),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEAEFF3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      margin:  EdgeInsets.symmetric(horizontal:width*0.02 ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xffF59E0B), width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 2),
    );

    return Pinput(
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      errorPinTheme: errorPinTheme,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      showCursor: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the code';
        }
        if (value.length < 4) {
          return 'Complete the code';
        }
        return null;
      },
      onCompleted: onCompleted,
    );
  }
}

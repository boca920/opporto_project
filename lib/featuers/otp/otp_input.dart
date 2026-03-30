import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpInput extends StatefulWidget {
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final String? errorText;
  final TextEditingController? controller;
  final bool readOnly;

  const OtpInput({
    super.key,
    this.onCompleted,
    this.onChanged,
    this.errorText,
    this.controller,
    this.readOnly = false,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final TextEditingController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasError = widget.errorText != null;
  }

  @override
  void didUpdateWidget(OtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null) {
      _hasError = true;
    } else {
      _hasError = false;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 68,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(0xff1E3C57),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _hasError ? Colors.red : const Color(0xffEAEFF3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.005),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(
          color: const Color(0xffF59E0B),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffF59E0B).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border:  Border.all(color: Colors.red, width: 3),
        color: Colors.red.withOpacity(0.1),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.green, width: 2),
      ),
    );

    return Column(
      children: [
        // ✅ Pinput الرئيسي
        Pinput(
          controller: _controller,
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorPinTheme,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          showCursor: true,
          enableSuggestions: false,
          errorText: widget.errorText,
          onChanged: (value) {
            // ✅ Clear error on typing
            if (widget.errorText != null && value.isNotEmpty) {
              // يتم التعامل مع error في الـ parent
            }
            widget.onChanged?.call(value);
          },
          onCompleted: (pin) {
            print("✅ OTP Completed: $pin");
            widget.onCompleted?.call(pin);
          },
          onSubmitted: (pin) {
            print("✅ OTP Submitted: $pin");
            widget.onCompleted?.call(pin);
          },
          textInputAction: TextInputAction.done,
          closeKeyboardWhenCompleted: true,

          animationDuration: const Duration(milliseconds: 200),
          animationCurve: Curves.easeInOut,

          validator: (s) {
            if (s == null || s.isEmpty) {
              return null; // الـ parent يتعامل مع الـ validation
            }
            return null;
          },
        ),

        // ✅ Error message أسفل (اختياري)
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.errorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
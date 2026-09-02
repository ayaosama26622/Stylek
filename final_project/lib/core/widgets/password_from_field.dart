import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class PasswordFromField extends StatefulWidget {
  const PasswordFromField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordFromField> createState() => _PasswordFromFieldState();
}

class _PasswordFromFieldState extends State<PasswordFromField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        style: TextStyle(color: AppColor.onSurface(context), fontSize: 15),
        validator:
            widget.validator ??
            (input) {
              if (input == null || input.isEmpty) {
                return 'auth.password_required'.tr();
              } else if (input.length < 8) {
                return 'auth.password_too_short'.tr();
              }
              return null;
            },
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
          filled: false,

          hintStyle: TextStyle(color: AppColor.greyColor(context), fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          prefixIcon: Icon(Icons.lock_outline, color: AppColor.greyColor(context)),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColor.greyColor(context),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),

            borderSide: const BorderSide(
              color: AppColor.primaryBlue,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}

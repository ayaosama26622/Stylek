// Shared "label + bordered input + inline error" field used across the
// Sign In and Sign Up forms. Extracted from 6 near-identical duplicated
// blocks (username, email, password, confirm password on each screen).
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/custom_text_from_field.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final String? errorText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColor.onSurface(context),
            ),
          ),
        ),
        const SizedBox(height: 8),
        CustomGradientBorder(
          borderRadius: BorderRadius.circular(8),
          child: CustomTextFormField(
            controller: controller,
            hintText: hintText,
            prefixIcon: prefixIcon,
            obscureText: obscureText,
            suffixIcon: suffixIcon,
            keyboardType: keyboardType,
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                errorText!,
                style: const TextStyle(
                  color: AppColor.errorColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

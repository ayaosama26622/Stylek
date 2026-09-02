import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_project/core/styles/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChange,
    this.textInputAction,
    this.controller,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.obscureText = false,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final int? maxLines;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        focusNode: focusNode,
        maxLines: maxLines,
        obscureText: obscureText,
        textAlign: textAlign,
        textInputAction: textInputAction,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            LengthLimitingTextInputFormatter(11),
        ],
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: TextStyle(color: AppColor.onSurface(context), fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          isDense: true,
          filled: false,

          hintStyle: TextStyle(color: AppColor.greyColor(context), fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
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
        validator: validator,
        onChanged: onChange,
        onTap: onTap,
      ),
    );
  }
}

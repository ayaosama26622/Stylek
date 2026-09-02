import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor = AppColor.primaryPink,
    this.borderColor,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.textColor,
  });

  final String text;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color? borderColor;
  final double minWidth;
  final double minHeight;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bool useGradient = bgColor == AppColor.primaryPink;
    final Color resolvedTextColor = textColor ?? AppColor.darkColor(context);

    return Container(
      width: minWidth,
      height: minHeight,
      decoration: useGradient
          ? BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColor.gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: useGradient ? Colors.transparent : bgColor,
          shadowColor: useGradient ? Colors.transparent : null,
          minimumSize: Size(minWidth, minHeight),
          maximumSize: Size(minWidth, minHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: resolvedTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// Simple centered page title used on the Forgot Password, New Password,
// and Verification Code screens (no back button, no illustration —
// just a bold centered heading above the form).
import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppCenteredTitle extends StatelessWidget {
  const AppCenteredTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppColor.onSurface(context),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

class PageTitleSection extends StatelessWidget {
  const PageTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: AppColor.onSurface(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: AppColor.mutedVisible(context),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

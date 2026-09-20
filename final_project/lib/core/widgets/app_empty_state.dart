// Shared "nothing here yet" state: an icon, a bold title, and an optional
// grey subtitle, centered with consistent padding. Used wherever a list
// or grid has no items to show (My Orders, Favorites, etc).
import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColor.greyColor(context)),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColor.onSurface(context),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.greyColor(context).withValues(alpha: 0.9),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

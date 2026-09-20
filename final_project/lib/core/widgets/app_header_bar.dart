// Shared "back button + centered title" header row used at the top of
// nearly every screen in the app. Extracted from duplicated per-screen
// implementations to keep the header style consistent in one place.
import 'package:final_project/core/functions/rtl_icon.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppHeaderBar extends StatelessWidget {
  const AppHeaderBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  /// The centered title text.
  final String title;

  /// Called when the back button is tapped. If null, no back button is
  /// shown and the title stays centered using a matching spacer instead.
  final VoidCallback? onBack;

  /// Optional widget shown where the trailing spacer would otherwise be
  /// (e.g. an action icon). Defaults to a 36-wide spacer matching the
  /// back button's width so the title stays visually centered.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          if (onBack != null)
            AppBackButton(onTap: onBack!)
          else
            const SizedBox(width: 36),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColor.onSurface(context),
              ),
            ),
          ),
          trailing ?? const SizedBox(width: 36),
        ],
      ),
    );
  }
}

/// The small circular back-chevron button reused by [AppHeaderBar] and
/// anywhere else a standalone back button is needed.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, required this.onTap, this.size = 36});

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.surface(context),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.darkColor(context).withValues(alpha: 0.07),
              blurRadius: 6,
            ),
          ],
        ),
        child: mirrorForRtl(
          context,
          Icon(
            Icons.chevron_left,
            color: AppColor.onSurface(context),
            size: 22,
          ),
        ),
      ),
    );
  }
}

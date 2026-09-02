// Shared page shell used by every screen: forces LTR layout, applies the
// app's light/dark-aware background gradient, and wraps content in a
// SafeArea. Extracted from identical boilerplate that was copy-pasted
// into every screen file.
import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppGradientScaffold extends StatelessWidget {
  const AppGradientScaffold({
    super.key,
    required this.body,
    this.safeAreaBottom = false,
  });

  /// The screen's content, placed below the SafeArea insets. Typically a
  /// Column starting with an [AppHeaderBar] followed by an Expanded body.
  final Widget body;

  /// Whether the SafeArea should also pad the bottom edge. Most screens
  /// leave this false since their content scrolls under the bottom nav.
  final bool safeAreaBottom;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
          child: SafeArea(bottom: safeAreaBottom, child: body),
        ),
      ),
    );
  }
}

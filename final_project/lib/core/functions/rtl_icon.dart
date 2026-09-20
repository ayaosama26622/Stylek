import 'package:flutter/material.dart';

/// Wraps a directional icon (chevrons, back arrows, etc.) so it visually
/// flips when the app is in a right-to-left language (Arabic).
///
/// Flutter's [Icon] widget, unlike [Image], has no `matchTextDirection`
/// parameter, so icons that imply a direction (e.g. `chevron_left` meaning
/// "back") don't mirror automatically under RTL locales. This does that
/// mirroring manually.
Widget mirrorForRtl(BuildContext context, Widget icon) {
  final isRtl = Directionality.of(context) == TextDirection.rtl;
  if (!isRtl) return icon;
  return Transform.flip(flipX: true, child: icon);
}

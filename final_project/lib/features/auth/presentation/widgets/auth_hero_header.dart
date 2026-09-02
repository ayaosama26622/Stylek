import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AuthHeroHeader extends StatelessWidget {
  const AuthHeroHeader({
    super.key,
    required this.title,
    required this.imagePath,
    required this.fallbackIcon,
    required this.imageHeight,
    this.titleFontSize = 28,
    this.fallbackIconSize = 110,
  });

  final String title;
  final String imagePath;
  final IconData fallbackIcon;
  final double imageHeight;
  final double titleFontSize;
  final double fallbackIconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColor.onSurface(context),
            letterSpacing: 0.5,
          ).copyWith(fontSize: titleFontSize),
        ),
        const SizedBox(height: 20),
        Image.asset(
          imagePath,
          height: imageHeight,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              fallbackIcon,
              size: fallbackIconSize,
              color: AppColor.greyColor(context),
            );
          },
        ),
      ],
    );
  }
}

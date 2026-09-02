import 'package:final_project/core/styles/colors.dart';
import 'package:flutter/material.dart';

class PillCategoryChip extends StatelessWidget {
  const PillCategoryChip({
    super.key,
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade200 : AppColor.surface(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColor.onSurface(context),
        ),
      ),
    );
  }
}

class IconCategoryChip extends StatelessWidget {
  const IconCategoryChip({
    super.key,
    required this.label,
    this.icon,
    this.imagePath,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final String? imagePath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColor.primaryBlue.withValues(alpha: 0.35)
              : AppColor.surface(context),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: [
            if (imagePath != null) ...[
              Image.asset(
                imagePath!,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                color: AppColor.onSurface(context),
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.checkroom_outlined,
                  size: 18,
                  color: AppColor.onSurface(context),
                ),
              ),
              const SizedBox(width: 6),
            ] else if (icon != null) ...[
              Icon(icon, size: 18, color: AppColor.onSurface(context)),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColor.onSurface(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

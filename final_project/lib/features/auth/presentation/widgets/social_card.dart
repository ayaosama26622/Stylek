import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

class SocialCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const SocialCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomGradientBorder(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColor.surface(context).withValues(alpha: 0.9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColor.onSurface(context),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

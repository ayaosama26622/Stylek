import 'package:final_project/core/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class DiscountCodeField extends StatelessWidget {
  const DiscountCodeField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkColor(context).withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 13, color: AppColor.onSurface(context)),
              decoration: InputDecoration(
                hintText: 'cart.enter_discount_code'.tr(),
                hintStyle: TextStyle(color: AppColor.mutedOnCard(context), fontSize: 13),
                filled: true,
                fillColor: AppColor.surface(context),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 14),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColor.gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'cart.apply_code'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColor.darkColor(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

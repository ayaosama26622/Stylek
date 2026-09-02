import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/filter/data/model/filter_option_model.dart';
import 'package:flutter/material.dart';

class FilterChipWrap extends StatelessWidget {
  const FilterChipWrap({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<FilterOptionModel> items;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.35,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final selected = selectedValue == item.label;
        return GestureDetector(
          onTap: () => onSelected(item.label),
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColor.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selected
                    ? AppColor.primaryBlue.withValues(alpha: 0.75)
                    : AppColor.surface(context),
                borderRadius: BorderRadius.circular(14.5),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.imagePath != null) ...[
                      Image.asset(
                        item.imagePath!,
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                        color: AppColor.greyColor(context),
                        colorBlendMode: BlendMode.srcIn,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(
                              Icons.checkroom_outlined,
                              size: 20,
                              color: AppColor.greyColor(context),
                            ),
                      ),
                      const SizedBox(width: 8),
                    ] else if (item.icon != null) ...[
                      Icon(item.icon, size: 20, color: AppColor.greyColor(context)),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      translateOptionLabel(item.label),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColor.greyColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

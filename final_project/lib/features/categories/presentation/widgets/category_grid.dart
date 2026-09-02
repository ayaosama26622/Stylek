import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/categories/data/model/categories_option_model.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<CategoriesOptionModel> categories;
  final String? selectedCategory;
  final ValueChanged<CategoriesOptionModel> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.8,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final selected = selectedCategory == category.label;
        return GestureDetector(
          onTap: () => onSelected(category),
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColor.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? AppColor.primaryBlue.withValues(alpha: 0.7)
                    : AppColor.surface(context),
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (category.imagePath != null) ...[
                    Image.asset(
                      category.imagePath!,
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
                    const SizedBox(width: 8),
                  ] else ...[
                    Icon(
                      category.icon ?? Icons.checkroom_outlined,
                      size: 18,
                      color: AppColor.onSurface(context),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    translateOptionLabel(category.label),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

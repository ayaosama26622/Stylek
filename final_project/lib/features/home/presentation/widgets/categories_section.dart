import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/features/home/data/model/category_model.dart';
import 'package:final_project/features/home/presentation/widgets/category_chip_widgets.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.genderCategories,
    required this.typeCategories,
    required this.selectedGenderIndex,
    required this.selectedTypeIndex,
    required this.onGenderSelected,
    required this.onTypeSelected,
    this.onSeeAll,
  });

  final List<CategoryModel> genderCategories;
  final List<CategoryModel> typeCategories;
  final int? selectedGenderIndex;
  final int selectedTypeIndex;
  final ValueChanged<int> onGenderSelected;
  final ValueChanged<int> onTypeSelected;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'home.categories'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColor.onSurface(context),
              ),
            ),
            SeeAllButton(onTap: onSeeAll),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          textDirection: TextDirection.ltr,
          children: List.generate(genderCategories.length, (index) {
            final selected =
                selectedGenderIndex != null && index == selectedGenderIndex;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == genderCategories.length - 1 ? 0 : 10,
                ),
                child: GestureDetector(
                  onTap: () => onGenderSelected(index),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF8B4F1), Color(0xFFA2C9FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PillCategoryChip(
                      label: translateOptionLabel(genderCategories[index].label),
                      selected: selected,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: typeCategories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = typeCategories[index];
              final selected = index == selectedTypeIndex;
              return Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF8B4F1), Color(0xFFA2C9FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.blue.shade200
                        : AppColor.surface(context),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconCategoryChip(
                    label: translateOptionLabel(category.label),
                    icon: category.icon,
                    imagePath: category.imagePath,
                    selected: selected,
                    onTap: () => onTypeSelected(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SeeAllButton extends StatefulWidget {
  const SeeAllButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<SeeAllButton> createState() => _SeeAllButtonState();
}

class _SeeAllButtonState extends State<SeeAllButton> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 90),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedOpacity(
            opacity: _isPressed ? 0.55 : 1,
            duration: const Duration(milliseconds: 90),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Text(
                'common.see_all'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.errorColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

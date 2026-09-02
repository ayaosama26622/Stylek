import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class ProductFilterValue {
  const ProductFilterValue({
    this.gender,
    this.category,
    this.color,
    this.season,
    this.priceRange = const RangeValues(0, 2500),
  });

  final String? gender;
  final String? category;
  final String? color;
  final String? season;
  final RangeValues priceRange;

  bool get hasFilters =>
      gender != null ||
      category != null ||
      color != null ||
      season != null ||
      priceRange.start > 0 ||
      priceRange.end < 2500;

  ProductFilterValue copyWith({
    String? gender,
    String? category,
    String? color,
    String? season,
    RangeValues? priceRange,
    bool clearGender = false,
    bool clearCategory = false,
    bool clearColor = false,
    bool clearSeason = false,
  }) {
    return ProductFilterValue(
      gender: clearGender ? null : gender ?? this.gender,
      category: clearCategory ? null : category ?? this.category,
      color: clearColor ? null : color ?? this.color,
      season: clearSeason ? null : season ?? this.season,
      priceRange: priceRange ?? this.priceRange,
    );
  }

  bool matches(ProductModel product) {
    final genderMatches = gender == null || product.gender == gender;
    final categoryMatches = category == null || product.category == category;
    final colorMatches = color == null || product.color == color;
    final seasonMatches = season == null || product.season == season;
    final priceMatches =
        product.price >= priceRange.start && product.price <= priceRange.end;
    return genderMatches &&
        categoryMatches &&
        colorMatches &&
        seasonMatches &&
        priceMatches;
  }
}

Future<ProductFilterValue?> showProductFilterBottomSheet({
  required BuildContext context,
  required ProductFilterValue initialValue,
}) {
  return showModalBottomSheet<ProductFilterValue>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.surface(context),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      var value = initialValue;
      return StatefulBuilder(
        builder: (context, setSheetState) {
          void toggle({
            required String field,
            required String selectedValue,
          }) {
            setSheetState(() {
              if (field == 'gender') {
                value = value.gender == selectedValue
                    ? value.copyWith(clearGender: true)
                    : value.copyWith(gender: selectedValue);
              } else if (field == 'category') {
                value = value.category == selectedValue
                    ? value.copyWith(clearCategory: true)
                    : value.copyWith(category: selectedValue);
              } else if (field == 'color') {
                value = value.color == selectedValue
                    ? value.copyWith(clearColor: true)
                    : value.copyWith(color: selectedValue);
              } else if (field == 'season') {
                value = value.season == selectedValue
                    ? value.copyWith(clearSeason: true)
                    : value.copyWith(season: selectedValue);
              }
            });
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'filter.title'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColor.onSurface(context),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setSheetState(
                          () => value = const ProductFilterValue(),
                        ),
                        child: Text('filter.reset'.tr()),
                      ),
                    ],
                  ),
                  _FilterGroup(
                    title: 'filter.gender'.tr(),
                    values: const ['Man', 'Woman', 'Baby'],
                    selected: value.gender,
                    onSelected: (item) =>
                        toggle(field: 'gender', selectedValue: item),
                  ),
                  _FilterGroup(
                    title: 'filter.category'.tr(),
                    values: const [
                      'Offers',
                      'Dress',
                      'Shirt',
                      'Jacket',
                      'Pants',
                      'Shorts',
                      'Jeep',
                      'Bag',
                    ],
                    selected: value.category,
                    onSelected: (item) =>
                        toggle(field: 'category', selectedValue: item),
                  ),
                  _FilterGroup(
                    title: 'filter.color'.tr(),
                    values: const ['Black', 'White', 'Navy', 'Brown', 'Grey'],
                    selected: value.color,
                    onSelected: (item) =>
                        toggle(field: 'color', selectedValue: item),
                  ),
                  _FilterGroup(
                    title: 'filter.season'.tr(),
                    values: const ['Summer', 'Winter', 'Spring', 'Autumn'],
                    selected: value.season,
                    onSelected: (item) =>
                        toggle(field: 'season', selectedValue: item),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'filter.price'.tr()}  EGP ${value.priceRange.start.round()} - ${value.priceRange.end.round()}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                  RangeSlider(
                    min: 0,
                    max: 2500,
                    divisions: 25,
                    values: value.priceRange,
                    activeColor: AppColor.onSurface(context),
                    onChanged: (range) => setSheetState(
                      () => value = value.copyWith(priceRange: range),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryPink,
                        foregroundColor: AppColor.darkColor(context),
                      ),
                      onPressed: () => Navigator.pop(context, value),
                      child: Text(
                        'filter.apply_filter'.tr(),
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _FilterGroup extends StatelessWidget {
  const _FilterGroup({
    required this.title,
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> values;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColor.onSurface(context),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: values.map((item) {
              final isSelected = selected == item;
              return ChoiceChip(
                label: Text(translateOptionLabel(item)),
                selected: isSelected,
                onSelected: (_) => onSelected(item),
                selectedColor: AppColor.primaryBlue.withValues(alpha: 0.55),
                backgroundColor: AppColor.surface(context),
                side: BorderSide(
                  color: isSelected ? AppColor.onSurface(context) : AppColor.mutedOnCard(context),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

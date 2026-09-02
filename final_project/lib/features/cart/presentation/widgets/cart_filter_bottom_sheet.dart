import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class CartFilterValue {
  const CartFilterValue({this.color, this.size});

  final String? color;
  final String? size;

  bool get hasFilters => color != null || size != null;

  CartFilterValue copyWith({
    String? color,
    String? size,
    bool clearColor = false,
    bool clearSize = false,
  }) {
    return CartFilterValue(
      color: clearColor ? null : color ?? this.color,
      size: clearSize ? null : size ?? this.size,
    );
  }

  bool matches(CartItemModel item) {
    final colorMatches = color == null || item.color == color;
    final sizeMatches = size == null || item.size == size;
    return colorMatches && sizeMatches;
  }
}

Future<CartFilterValue?> showCartFilterBottomSheet({
  required BuildContext context,
  required CartFilterValue initialValue,
}) {
  return showModalBottomSheet<CartFilterValue>(
    context: context,
    backgroundColor: AppColor.surface(context),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      var value = initialValue;
      return StatefulBuilder(
        builder: (context, setSheetState) {
          void toggleColor(String item) {
            setSheetState(() {
              value = value.color == item
                  ? value.copyWith(clearColor: true)
                  : value.copyWith(color: item);
            });
          }

          void toggleSize(String item) {
            setSheetState(() {
              value = value.size == item
                  ? value.copyWith(clearSize: true)
                  : value.copyWith(size: item);
            });
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'cart.cart_filter'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColor.onSurface(context),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setSheetState(
                          () => value = const CartFilterValue(),
                        ),
                        child: Text('cart.reset'.tr()),
                      ),
                    ],
                  ),
                  _CartFilterGroup(
                    title: 'cart.color'.tr(),
                    values: const ['Default', 'Black', 'White', 'Navy', 'Brown', 'Grey'],
                    selected: value.color,
                    onSelected: toggleColor,
                  ),
                  _CartFilterGroup(
                    title: 'cart.size'.tr(),
                    values: const ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                    selected: value.size,
                    onSelected: toggleSize,
                  ),
                  const SizedBox(height: 16),
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
                        'cart.apply_filter'.tr(),
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

class _CartFilterGroup extends StatelessWidget {
  const _CartFilterGroup({
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

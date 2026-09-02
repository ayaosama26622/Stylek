import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

part 'cart_item_option_row.dart';
part 'cart_item_quantity_control.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
    required this.onColorChanged,
    required this.onSizeChanged,
  });

  final CartItemModel item;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<String> onColorChanged;
  final ValueChanged<String> onSizeChanged;

  static const List<String> colorOptions = [
    'Default',
    'Navy',
    'Black',
    'Brown',
    'White',
    'Red',
  ];

  static const List<String> sizeOptions = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkColor(context).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.image,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 88,
                      height: 88,
                      color: AppColor.greyColor(context).withValues(alpha: 0.12),
                      child: Icon(
                        Icons.checkroom_outlined,
                        color: AppColor.mutedOnCard(context),
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.localizedName(context),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColor.onSurface(context),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onDelete,
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: AppColor.errorColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'EGP ${item.unitPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColor.errorColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _OptionRow(
                        label: 'cart.color'.tr(),
                        value: item.color,
                        options: colorOptions,
                        onChanged: onColorChanged,
                        translateOptions: true,
                      ),
                      const SizedBox(height: 6),
                      _OptionRow(
                        label: 'cart.size'.tr(),
                        value: item.size,
                        options: sizeOptions,
                        onChanged: onSizeChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColor.greyColor(context).withValues(alpha: 0.2),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColor.onSurface(context),
                    ),
                    children: [
                      TextSpan(text: 'cart.total_label'.tr()),
                      TextSpan(
                        text: '${item.lineTotal.toStringAsFixed(0)} EGP',
                        style: const TextStyle(color: AppColor.errorColor),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _CartQuantityControl(
                  quantity: item.quantity,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

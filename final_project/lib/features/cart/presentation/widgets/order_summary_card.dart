import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.summary});

  final CartSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          _SummaryRow(
            label: 'cart.subtotal'.tr(),
            value: '${summary.subtotal.toStringAsFixed(2)} EGP',
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'cart.delivery_fee'.tr(),
            value: '${summary.deliveryFee.toStringAsFixed(2)} EGP',
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: summary.discountLabel,
            value: '${summary.discount.toStringAsFixed(2)} EGP',
          ),
          const SizedBox(height: 12),
          Divider(color: AppColor.greyColor(context).withValues(alpha: 0.25)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'cart.total'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColor.errorColor,
                ),
              ),
              Text(
                '${summary.total.toStringAsFixed(0)} EGP',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColor.errorColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColor.onSurface(context).withValues(alpha: 0.85),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColor.onSurface(context),
          ),
        ),
      ],
    );
  }
}

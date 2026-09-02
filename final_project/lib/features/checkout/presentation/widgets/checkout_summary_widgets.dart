part of '../page/checkout_screen.dart';

class _CheckoutSummaryCard extends StatelessWidget {
  const _CheckoutSummaryCard({
    required this.items,
    required this.pricing,
  });

  final List<CartItemModel> items;
  final CheckoutPricingModel pricing;

  @override
  Widget build(BuildContext context) {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.lineTotal);
    final deliveryFee = items.isEmpty ? 0.0 : pricing.deliveryFee;
    final discount = pricing.discountFor(subtotal);
    final total = subtotal + deliveryFee - discount;
    return Material(
      color: AppColor.surface(context),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
        child: Column(
          children: [
            _CheckoutSummaryRow(
              label: 'checkout.subtotal'.tr(),
              value: '${subtotal.toStringAsFixed(2)} EGP',
            ),
            const SizedBox(height: 16),
            _CheckoutSummaryRow(
              label: 'checkout.delivery_fee'.tr(),
              value: '${deliveryFee.toStringAsFixed(2)} EGP',
            ),
            const SizedBox(height: 16),
            _CheckoutSummaryRow(
              label: pricing.discountLabel,
              value: '${discount.toStringAsFixed(2)} EGP',
            ),
            const SizedBox(height: 12),
            Divider(color: AppColor.greyColor(context).withValues(alpha: 0.35)),
            const SizedBox(height: 10),
            _CheckoutSummaryRow(
              label: 'checkout.total'.tr(),
              value: '${total.toStringAsFixed(2)} EGP',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutSummaryRow extends StatelessWidget {
  const _CheckoutSummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final color = isTotal ? AppColor.errorColor : AppColor.onSurface(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 11,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 13 : 11,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

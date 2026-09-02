part of '../page/product_details_screen.dart';

class _CartQuantityRow extends StatelessWidget {
  const _CartQuantityRow({
    required this.quantity,
    required this.onAddToCart,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onAddToCart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onAddToCart,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.primaryPink,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.darkColor(context).withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 20,
                    color: AppColor.darkColor(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'details.add_to_cart'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColor.darkColor(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        _QuantityButton(icon: Icons.remove, filled: false, onTap: onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColor.onSurface(context),
            ),
          ),
        ),
        _QuantityButton(icon: Icons.add, filled: true, onTap: onIncrement),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? AppColor.darkColor(context) : AppColor.surface(context),
          borderRadius: BorderRadius.circular(8),
          border: filled
              ? null
              : Border.all(
                  color: AppColor.onSurface(context).withValues(alpha: 0.35),
                ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? AppColor.whiteColor : AppColor.onSurface(context),
        ),
      ),
    );
  }
}

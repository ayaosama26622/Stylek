part of 'cart_item_card.dart';

class _CartQuantityControl extends StatelessWidget {
  const _CartQuantityControl({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QtyButton(icon: Icons.remove, filled: false, onTap: onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColor.onSurface(context),
            ),
          ),
        ),
        _QtyButton(icon: Icons.add, filled: true, onTap: onIncrement),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
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

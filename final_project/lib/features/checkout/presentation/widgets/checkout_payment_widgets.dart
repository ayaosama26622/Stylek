part of '../page/checkout_screen.dart';

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColor.isDark(context)
              ? const Color(0xFF3A3A3A)
              : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: isSelected ? AppColor.primaryPink : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColor.onSurface(context) : AppColor.mutedOnCard(context),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppColor.onSurface(context)
                    : AppColor.mutedOnCard(context),
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: AppColor.onSurface(context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OtherMethodsTile extends StatelessWidget {
  const _OtherMethodsTile({this.isSelected = false, this.onTap});

  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.isDark(context)
              ? const Color(0xFF3A3A3A)
              : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: isSelected ? AppColor.primaryPink : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: 18,
              color: isSelected ? AppColor.onSurface(context) : AppColor.mutedOnCard(context),
            ),
            const SizedBox(width: 8),
            Text(
              'checkout.other_methods'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppColor.onSurface(context)
                    : AppColor.mutedOnCard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

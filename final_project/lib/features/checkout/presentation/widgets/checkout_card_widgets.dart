part of '../page/checkout_screen.dart';

class _CheckoutCard extends StatelessWidget {
  const _CheckoutCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColor.greyColor(context)),
            const SizedBox(width: 7),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColor.greyColor(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Material(
          color: AppColor.surface(context),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckoutInput extends StatelessWidget {
  const _CheckoutInput({
    required this.icon,
    required this.hint,
    required this.controller,
  });

  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.isDark(context)
            ? const Color(0xFF3A3A3A)
            : const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColor.greyColor(context)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 12, color: AppColor.onSurface(context)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.mutedOnCard(context),
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

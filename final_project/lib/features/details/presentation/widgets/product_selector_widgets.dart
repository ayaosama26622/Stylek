part of '../page/product_details_screen.dart';

class _SizeSelector extends StatelessWidget {
  const _SizeSelector({
    required this.sizes,
    required this.selectedSize,
    required this.onSelected,
  });

  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sizes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final size = sizes[index];
          final selected = size == selectedSize;
          return GestureDetector(
            onTap: () => onSelected(size),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? AppColor.primaryBlue.withValues(alpha: 0.5)
                    : AppColor.surface(context),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.onSurface(context).withValues(alpha: 0.85),
                  width: 1.2,
                ),
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColor.onSurface(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ColorSelector extends StatelessWidget {
  const _ColorSelector({
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<ProductColorOption> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final color = colors[index];
          final selected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? AppColor.onSurface(context)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  color.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColor.greyColor(context).withValues(alpha: 0.15),
                    child: Icon(Icons.checkroom_outlined, color: AppColor.mutedOnCard(context), size: 24),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

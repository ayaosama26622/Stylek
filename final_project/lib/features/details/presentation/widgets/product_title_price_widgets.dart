part of '../page/product_details_screen.dart';

class _ProductTitleRow extends StatelessWidget {
  const _ProductTitleRow({
    required this.name,
    required this.rating,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final String name;
  final double rating;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.onSurface(context),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 24, color: Colors.amber),
                  const SizedBox(width: 2),
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColor.greyColor(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onFavoriteTap,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? AppColor.errorColor : AppColor.greyColor(context),
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.price, this.oldPrice, this.shippingFee});

  final double price;
  final double? oldPrice;
  final double? shippingFee;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'EGP ${price.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppColor.errorColor,
          ),
        ),
        if (oldPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            'EGP ${oldPrice!.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.mutedVisible(context),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
        if (shippingFee != null) ...[
          const Spacer(),
          Icon(Icons.eco_outlined, size: 16, color: AppColor.greyColor(context)),
          const SizedBox(width: 4),
          Text(
            '${shippingFee!.toStringAsFixed(0)} EGP',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColor.greyColor(context),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: AppColor.onSurface(context),
      ),
    );
  }
}

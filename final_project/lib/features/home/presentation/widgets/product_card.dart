import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/data/repo/home_repo.dart';
import 'package:final_project/features/home/domain/usecase/home_usecases.dart';
import 'package:final_project/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

enum ProductCardFooterStyle {
  shippingOnly,

  soldCountOnly,

  soldCountAndShipping,
}

String formatSoldCount(int count) {
  if (count >= 1000) {
    final k = count / 1000;
    if (k >= 10) return '${k.round()}k sold';
    return '${k.toStringAsFixed(k == k.roundToDouble() ? 0 : 1)}k sold';
  }
  return '$count sold';
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.footerStyle = ProductCardFooterStyle.shippingOnly,
    this.onTap,
    this.initialFavorite = false,
  });

  final ProductModel product;
  final ProductCardFooterStyle footerStyle;
  final VoidCallback? onTap;
  final bool initialFavorite;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool _isFavorite = widget.initialFavorite;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(HomeUseCases(HomeRepo()));
  }

  @override
  void dispose() {
    _homeCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.surface(context),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColor.darkColor(context).withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColor.greyColor(context).withValues(alpha: 0.15),
                        child: Icon(
                          Icons.checkroom_outlined,
                          color: AppColor.mutedOnCard(context),
                          size: 36,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () async {
                        final nextValue = !_isFavorite;
                        setState(() => _isFavorite = nextValue);
                        try {
                          await _homeCubit.toggleFavorite(product, nextValue);
                        } catch (_) {
                          if (mounted) setState(() => _isFavorite = !nextValue);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: _isFavorite ? AppColor.errorColor : AppColor.greyColor(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.localizedName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        'EGP ${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColor.errorColor,
                        ),
                      ),
                      if (product.oldPrice != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          'EGP ${product.oldPrice!.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.mutedVisible(context),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  _ProductCardFooter(
                    product: product,
                    footerStyle: widget.footerStyle,
                    homeCubit: _homeCubit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCardFooter extends StatelessWidget {
  const _ProductCardFooter({
    required this.product,
    required this.footerStyle,
    required this.homeCubit,
  });

  final ProductModel product;
  final ProductCardFooterStyle footerStyle;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        AddToCartButton(
          product: product,
          homeCubit: homeCubit,
        ),
        const SizedBox(width: 6),
        const Icon(Icons.star, size: 16, color: Colors.amber),
        const SizedBox(width: 2),
        Text(
          product.rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12,
            color: AppColor.onSurface(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (footerStyle == ProductCardFooterStyle.soldCountOnly ||
            footerStyle == ProductCardFooterStyle.soldCountAndShipping) ...[
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              formatSoldCount(product.soldCount),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 10,
                color: AppColor.mutedOnCard(context).withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        if (footerStyle == ProductCardFooterStyle.shippingOnly &&
            product.shippingFee != null) ...[
          const SizedBox(width: 4),
          const Spacer(),
          Icon(
            Icons.local_shipping_outlined,
            size: 14,
            color: AppColor.mutedOnCard(context),
          ),
          const SizedBox(width: 2),
          Text(
            '${product.shippingFee!.toStringAsFixed(0)} EGP',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        if (footerStyle == ProductCardFooterStyle.soldCountAndShipping &&
            product.shippingFee != null) ...[
          const SizedBox(width: 4),
          Container(
            width: 1,
            height: 12,
            color: AppColor.greyColor(context).withValues(alpha: 0.35),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.local_shipping_outlined,
            size: 12,
            color: AppColor.mutedOnCard(context),
          ),
          const SizedBox(width: 1),
          Text(
            product.shippingFee!.toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.homeCubit,
  });

  final ProductModel product;
  final HomeCubit homeCubit;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isAdded = false;

  Future<void> _toggleCart() async {
    final nextValue = !_isAdded;
    setState(() => _isAdded = nextValue);
    try {
      if (nextValue) {
        await widget.homeCubit.addToCart(widget.product);
        if (mounted) showSuccessSnackBar(context, 'common.added_to_cart'.tr());
      } else {
        await widget.homeCubit.removeFromCart(widget.product);
        if (mounted) showSuccessSnackBar(context, 'common.removed_from_cart'.tr());
      }
    } catch (error) {
      if (mounted) {
        setState(() => _isAdded = !nextValue);
        showErrorSnackBar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCart,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColor.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          decoration: BoxDecoration(
            color: _isAdded ? AppColor.primaryPink : AppColor.surface(context),
            borderRadius: BorderRadius.circular(8.5),
          ),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 16,
            color: _isAdded ? AppColor.darkColor(context) : AppColor.onSurface(context),
          ),
        ),
      ),
    );
  }
}

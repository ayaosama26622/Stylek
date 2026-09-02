import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/details/data/repo/details_repo.dart';
import 'package:final_project/features/details/domain/usecase/details_usecases.dart';
import 'package:final_project/features/details/presentation/cubit/details_cubit.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/details/presentation/widgets/product_review_card.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../widgets/product_details_widgets.dart';
part '../widgets/add_review_sheet.dart';
part '../widgets/product_image_widgets.dart';
part '../widgets/product_title_price_widgets.dart';
part '../widgets/product_cart_controls_widgets.dart';
part '../widgets/product_selector_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.detail});

  final ProductDetailModel detail;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  String? _selectedSize;
  int _selectedColorIndex = 0;
  bool _isFavorite = false;
  late final DetailsCubit _detailsCubit;

  @override
  void initState() {
    super.initState();
    _detailsCubit = DetailsCubit(DetailsUseCases(DetailsRepo()));
  }

  @override
  void dispose() {
    _detailsCubit.dispose();
    super.dispose();
  }

  ProductDetailModel get _detail => widget.detail;
  ProductModel get _product => _detail.product;

  void _incrementQuantity() => setState(() => _quantity++);
  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                AppHeaderBar(
                  title: 'details.product_details'.tr(),
                  onBack: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(Routes.home);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MainProductImage(image: _product.image),
                        const SizedBox(height: 16),
                        _ProductTitleRow(
                          name: _product.localizedName(context),
                          rating: _product.rating,
                          isFavorite: _isFavorite,
                          onFavoriteTap: () async {
                            final nextValue = !_isFavorite;
                            setState(() => _isFavorite = nextValue);
                            try {
                              await _detailsCubit.toggleFavorite(
                                _product,
                                nextValue,
                              );
                            } catch (_) {
                              if (mounted) {
                                setState(() => _isFavorite = !nextValue);
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _PriceRow(
                          price: _product.price,
                          oldPrice: _product.oldPrice,
                          shippingFee: _product.shippingFee,
                        ),
                        const SizedBox(height: 16),
                        _CartQuantityRow(
                          quantity: _quantity,
                          onAddToCart: () async {
                            try {
                              await _detailsCubit.addToCart(
                                product: _product,
                                color:
                                    _detail.colors[_selectedColorIndex].label,
                                size: _selectedSize ?? _detail.sizes.first,
                                quantity: _quantity,
                              );
                              if (context.mounted) {
                                showSuccessSnackBar(context, 'details.added_to_cart'.tr());
                              }
                            } catch (error) {
                              if (context.mounted) {
                                showErrorSnackBar(context, error.toString());
                              }
                            }
                          },
                          onIncrement: _incrementQuantity,
                          onDecrement: _decrementQuantity,
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle('details.size'.tr()),
                        const SizedBox(height: 10),
                        _SizeSelector(
                          sizes: _detail.sizes,
                          selectedSize: _selectedSize,
                          onSelected: (size) =>
                              setState(() => _selectedSize = size),
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle('details.colors'.tr()),
                        const SizedBox(height: 10),
                        _ColorSelector(
                          colors: _detail.colors,
                          selectedIndex: _selectedColorIndex,
                          onSelected: (index) =>
                              setState(() => _selectedColorIndex = index),
                        ),
                        const SizedBox(height: 24),
                        _SectionTitle('details.pictures_of_products'.tr()),
                        const SizedBox(height: 10),
                        _GalleryRow(images: _detail.galleryImages),
                        const SizedBox(height: 24),
                        _SectionTitle('details.reviews'.tr()),
                        const SizedBox(height: 10),
                        _ReviewsList(
                          productId: _product.id,
                          detailsCubit: _detailsCubit,
                        ),
                        const SizedBox(height: 8),
                        MainButton(
                          text: 'details.add_a_review'.tr(),
                          onPressed: () => _showAddReviewSheet(context),
                          minHeight: 52,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddReviewSheet(BuildContext context) async {
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.surface(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) => _AddReviewSheet(
        productId: _product.id,
        initialName: _detailsCubit.displayName,
        initialColor: _detail.colors[_selectedColorIndex].label,
        initialSize: _selectedSize ?? _detail.sizes.first,
        detailsCubit: _detailsCubit,
      ),
    );

    if (added == true && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showSuccessSnackBar(context, 'details.review_added'.tr());
      });
    }
  }
}

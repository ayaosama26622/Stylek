part of '../page/product_details_screen.dart';

class _ReviewsList extends StatelessWidget {
  const _ReviewsList({required this.productId, required this.detailsCubit});

  final String productId;
  final DetailsCubit detailsCubit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductReviewModel>>(
      stream: detailsCubit.watchReviews(productId),
      builder: (context, snapshot) {
        final reviews = snapshot.data ?? const <ProductReviewModel>[];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (reviews.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'details.no_reviews_yet'.tr(),
              style: TextStyle(color: AppColor.greyColor(context)),
            ),
          );
        }

        return Column(
          children: reviews
              .map(
                (review) => ProductReviewCard(
                  review: review,
                  productId: productId,
                  detailsCubit: detailsCubit,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

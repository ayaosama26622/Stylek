part of '../page/search_screen.dart';

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required this.query,
    required this.searchCubit,
    required this.filterValue,
  });

  final String query;
  final SearchCubit searchCubit;
  final ProductFilterValue filterValue;

  @override
  Widget build(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(
        child: Text(
          'search.empty_hint'.tr(),
          style: TextStyle(color: AppColor.greyColor(context)),
        ),
      );
    }

    return StreamBuilder<List<ProductModel>>(
      stream: searchCubit.searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GridShimmer(childAspectRatio: 0.68);
        }

        final products = (snapshot.data ?? const <ProductModel>[])
            .where(filterValue.matches)
            .toList();
        if (products.isEmpty) {
          return Center(
            child: Text(
              'common.no_products_found'.tr(),
              style: TextStyle(color: AppColor.greyColor(context)),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.only(bottom: 104),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              footerStyle: ProductCardFooterStyle.soldCountOnly,
              onTap: () => openProductDetails(context, product),
            );
          },
        );
      },
    );
  }
}

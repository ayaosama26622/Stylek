import 'package:final_project/core/functions/navigation.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class CategoryProductsGrid extends StatelessWidget {
  const CategoryProductsGrid({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'common.no_products_found'.tr(),
            style: TextStyle(color: AppColor.greyColor(context)),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProductCard(
            product: products[index],
            footerStyle: ProductCardFooterStyle.soldCountOnly,
            onTap: () => openProductDetails(context, products[index]),
          ),
          childCount: products.length,
        ),
      ),
    );
  }
}

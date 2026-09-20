import 'package:final_project/core/functions/navigation.dart';
import 'package:final_project/features/home/presentation/widgets/product_card.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.title,
    required this.products,
  });

  final String title;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.onSurface(context),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                const horizontalPadding = 32.0;
                const cardSpacing = 12.0;
                const childAspectRatio = 0.68;
                final cardWidth =
                    (constraints.maxWidth - horizontalPadding - cardSpacing) /
                    2;
                final cardHeight = cardWidth / childAspectRatio;

                return SizedBox(
                  height: cardHeight,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: products.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: cardSpacing),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        width: cardWidth,
                        child: ProductCard(
                          product: product,
                          onTap: () => openProductDetails(context, product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

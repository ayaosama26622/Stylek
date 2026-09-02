import 'package:final_project/core/functions/navigation.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_empty_state.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/features/filter/presentation/widgets/product_filter_bottom_sheet.dart';
import 'package:final_project/features/favorites/data/model/favorites_model.dart';
import 'package:final_project/features/favorites/data/repo/favorites_repo.dart';
import 'package:final_project/features/favorites/domain/usecase/favorites_usecases.dart';
import 'package:final_project/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:final_project/features/favorites/presentation/widgets/favorites_empty_state.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/product_card.dart';
import 'package:final_project/features/home/presentation/widgets/search_bar_with_filter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _searchController = TextEditingController();
  late final FavoritesCubit _favoritesCubit;
  String _query = '';
  ProductFilterValue _filterValue = const ProductFilterValue();

  @override
  void initState() {
    super.initState();
    _favoritesCubit = FavoritesCubit(FavoritesUseCases(FavoritesRepo()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _favoritesCubit.dispose();
    super.dispose();
  }

  List<ProductModel> _filteredProducts(List<ProductModel> products) {
    final normalizedQuery = _query.trim().toLowerCase();
    return products.where((product) {
      final queryMatches =
          normalizedQuery.isEmpty ||
          product.name.toLowerCase().contains(normalizedQuery) ||
          product.category.toLowerCase().contains(normalizedQuery) ||
          product.gender.toLowerCase().contains(normalizedQuery) ||
          product.section.toLowerCase().contains(normalizedQuery) ||
          product.color.toLowerCase().contains(normalizedQuery) ||
          product.season.toLowerCase().contains(normalizedQuery);
      return queryMatches && _filterValue.matches(product);
    }).toList();
  }

  Future<void> _openFilter() async {
    final nextValue = await showProductFilterBottomSheet(
      context: context,
      initialValue: _filterValue,
    );
    if (nextValue != null && mounted) {
      setState(() => _filterValue = nextValue);
    }
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
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeaderBar(
                  title: 'favorites.title'.tr(),
                  onBack: widget.onBack,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBarWithFilter(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    onFilterTap: _openFilter,
                    isFilterActive: _filterValue.hasFilters,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<FavoritesModel>(
                    stream: _favoritesCubit.watchFavorites(),
                    builder: (context, snapshot) {
                      final favorites =
                          snapshot.data ?? const FavoritesModel([]);
                      if (favorites.isEmpty) {
                        return const FavoritesEmptyState();
                      }
                      final products = _filteredProducts(favorites.products);
                      if (products.isEmpty) {
                        return AppEmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'favorites.empty'.tr(),
                        );
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.68,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) => ProductCard(
                          product: products[index].copyWith(isFavorite: true),
                          initialFavorite: true,
                          footerStyle: ProductCardFooterStyle.soldCountOnly,
                          onTap: () =>
                              openProductDetails(context, products[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

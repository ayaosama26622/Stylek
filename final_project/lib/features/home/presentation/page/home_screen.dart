import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/functions/navigation.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/home/data/model/home_catalog_model.dart';
import 'package:final_project/features/home/data/repo/home_repo.dart';
import 'package:final_project/features/home/domain/usecase/home_usecases.dart';
import 'package:final_project/features/home/presentation/cubit/home_cubit.dart';
import 'package:final_project/features/home/presentation/widgets/categories_section.dart';
import 'package:final_project/features/home/presentation/widgets/home_header.dart';
import 'package:final_project/features/home/presentation/widgets/page_title_section.dart';
import 'package:final_project/features/home/presentation/widgets/product_card.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/product_section.dart';
import 'package:final_project/features/home/presentation/widgets/promo_banner_card.dart';
import 'package:final_project/features/home/presentation/widgets/search_bar_with_filter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:go_router/go_router.dart';

class FashionHomeScreen extends StatefulWidget {
  const FashionHomeScreen({super.key});

  @override
  State<FashionHomeScreen> createState() => _FashionHomeScreenState();
}

class _FashionHomeScreenState extends State<FashionHomeScreen> {
  final _searchController = TextEditingController();
  int? _selectedGenderIndex;
  int _selectedCategoryIndex = 0;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit(HomeUseCases(HomeRepo()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _homeCubit.dispose();
    super.dispose();
  }

  List<ProductModel> get _manFilteredProducts {
    switch (_selectedCategoryIndex) {
      case 0:
        return [
          ...manNewArrivalProducts,
          ...manBestSellerProducts,
          ...manLuxuryPickProducts,
          ...manLimitedEditionProducts,
          ...manRecommendedProducts,
        ];
      case 1:
        return [...manNewArrivalProducts, ...manBestSellerProducts];
      case 2:
        return [...manLuxuryPickProducts, ...manLimitedEditionProducts];
      case 3:
        return [...manNewArrivalProducts, ...manRecommendedProducts];
      case 4:
        return [...manBestSellerProducts, ...manLuxuryPickProducts];
      case 5:
        return [...manLimitedEditionProducts, ...manRecommendedProducts];
      case 6:
        return [...manNewArrivalProducts, ...manLimitedEditionProducts];
      case 7:
        return [...manBestSellerProducts, ...manRecommendedProducts];
      case 8:
        return [...manLuxuryPickProducts, ...manRecommendedProducts];
      case 9:
        return manBestSellerProducts;
      default:
        return [];
    }
  }

  List<ProductModel> get _womanFilteredProducts {
    switch (_selectedCategoryIndex) {
      case 0:
        return womanCatalogProducts;
      case 1:
        return womanCatalogProducts.sublist(0, 2);
      case 2:
        return womanCatalogProducts.sublist(2, 4);
      case 3:
        return womanCatalogProducts.sublist(4, 6);
      case 4:
        return womanCatalogProducts.sublist(0, 3);
      case 5:
        return womanCatalogProducts.sublist(1, 4);
      case 6:
        return womanCatalogProducts.sublist(3, 6);
      case 7:
        return womanCatalogProducts.sublist(5, 8);
      case 8:
        return womanCatalogProducts.sublist(2, 5);
      case 9:
        return womanCatalogProducts.sublist(0, 2);
      default:
        return womanCatalogProducts;
    }
  }

  List<ProductModel> get _babyFilteredProducts {
    switch (_selectedCategoryIndex) {
      case 0:
        return babyCatalogProducts;
      case 1:
        return babyCatalogProducts.sublist(0, 2);
      case 2:
        return [babyCatalogProducts[0], babyCatalogProducts[3]];
      case 3:
        return [babyCatalogProducts[1], babyCatalogProducts[2]];
      case 4:
        return [babyCatalogProducts[2], babyCatalogProducts[3]];
      case 5:
        return [babyCatalogProducts[0], babyCatalogProducts[2]];
      case 6:
        return [babyCatalogProducts[1], babyCatalogProducts[3]];
      case 7:
        return babyCatalogProducts.sublist(0, 2);
      case 8:
        return babyCatalogProducts.sublist(2, 4);
      case 9:
        return babyCatalogProducts.sublist(0, 2);
      default:
        return babyCatalogProducts;
    }
  }

  void _onGenderSelected(int index) {
    setState(() {
      _selectedGenderIndex = _selectedGenderIndex == index ? null : index;
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  List<ProductModel> _fallbackProducts() {
    return [
      ...manNewArrivalProducts,
      ...manBestSellerProducts,
      ...manLuxuryPickProducts,
      ...manLimitedEditionProducts,
      ...manRecommendedProducts,
      ...womanCatalogProducts,
      ...babyCatalogProducts,
    ];
  }

  List<ProductModel> _sourceProducts(List<ProductModel>? liveProducts) {
    if (liveProducts != null && liveProducts.isNotEmpty) return liveProducts;
    return _fallbackProducts();
  }

  List<ProductModel> _sectionProducts(
    String section,
    List<ProductModel>? liveProducts,
  ) {
    return _sourceProducts(
      liveProducts,
    ).where((product) => product.section == section).toList();
  }

  List<ProductModel> _filteredLiveProducts(
    String gender,
    List<ProductModel>? liveProducts,
  ) {
    if (liveProducts == null || liveProducts.isEmpty) {
      if (gender == 'Man') return _manFilteredProducts;
      if (gender == 'Woman') return _womanFilteredProducts;
      return _babyFilteredProducts;
    }

    final products = _sourceProducts(liveProducts).where((product) {
      final sameGender = product.gender.toLowerCase() == gender.toLowerCase();
      final selectedCategory = homeTypeCategories[_selectedCategoryIndex].label;
      final sameCategory =
          selectedCategory == 'All' ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();
      final isOffer = _selectedCategoryIndex == 1 && product.oldPrice != null;
      return sameGender && (sameCategory || isOffer);
    }).toList();
    return products;
  }

  List<ProductModel> _filteredProducts(List<ProductModel>? liveProducts) {
    final selectedCategory = homeTypeCategories[_selectedCategoryIndex].label;
    final products = _sourceProducts(liveProducts).where((product) {
      final sameCategory =
          selectedCategory == 'All' ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();
      final isOffer = _selectedCategoryIndex == 1 && product.oldPrice != null;
      return sameCategory || isOffer;
    }).toList();
    return products;
  }

  Widget _buildContent(List<ProductModel>? liveProducts) {
    if (_selectedGenderIndex == null) {
      if (_selectedCategoryIndex == 0) {
        return _buildDefaultAllContent(liveProducts);
      }
      if (_selectedCategoryIndex == 1) {
        return _buildDefaultOffersContent(liveProducts);
      }
      return _buildProductGrid(
        key: ValueKey('category-$_selectedCategoryIndex'),
        products: _filteredProducts(liveProducts),
        footerStyle: ProductCardFooterStyle.soldCountOnly,
      );
    }

    return switch (_selectedGenderIndex!) {
      0 => _buildManContent(liveProducts),
      1 => _buildWomanContent(liveProducts),
      2 => _buildBabyContent(liveProducts),
      _ => _buildDefaultAllContent(liveProducts),
    };
  }

  Widget _buildDefaultAllContent(List<ProductModel>? liveProducts) {
    return CustomScrollView(
      key: const ValueKey('default-all'),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const PromoBannerCard(image: 'assets/images/girl.png'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ProductSection(
          title: 'home.new_arrival'.tr(),
          products: _sectionProducts('New Arrival', liveProducts),
        ),
        ProductSection(
          title: 'home.best_seller'.tr(),
          products: _sectionProducts('Best Seller', liveProducts),
        ),
        ProductSection(
          title: 'home.luxury_picks'.tr(),
          products: _sectionProducts('Luxury Picks', liveProducts),
        ),
        ProductSection(
          title: 'home.limited_edition'.tr(),
          products: _sectionProducts('Limited Edition', liveProducts),
        ),
        ProductSection(
          title: 'home.recommended_for_you'.tr(),
          products: _sectionProducts('Recommended For You', liveProducts),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildDefaultOffersContent(List<ProductModel>? liveProducts) {
    final products = _sourceProducts(
      liveProducts,
    ).where((product) => product.oldPrice != null).toList();
    return _buildProductGrid(
      key: const ValueKey('default-offers'),
      products: products,
      footerStyle: ProductCardFooterStyle.soldCountOnly,
    );
  }

  Widget _buildProductGrid({
    required Key key,
    required List<ProductModel> products,
    required ProductCardFooterStyle footerStyle,
  }) {
    return CustomScrollView(
      key: key,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        if (products.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                'home.no_products_found'.tr(),
                style: TextStyle(color: AppColor.greyColor(context)),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
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
                  footerStyle: footerStyle,
                  onTap: () => openProductDetails(context, products[index]),
                ),
                childCount: products.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildManContent(List<ProductModel>? liveProducts) {
    return _buildProductGrid(
      key: ValueKey('man-cat-$_selectedCategoryIndex'),
      products: _filteredLiveProducts('Man', liveProducts),
      footerStyle: ProductCardFooterStyle.soldCountOnly,
    );
  }

  Widget _buildWomanContent(List<ProductModel>? liveProducts) {
    return _buildProductGrid(
      key: ValueKey('woman-$_selectedCategoryIndex'),
      products: _filteredLiveProducts('Woman', liveProducts),
      footerStyle: ProductCardFooterStyle.soldCountOnly,
    );
  }

  Widget _buildBabyContent(List<ProductModel>? liveProducts) {
    return _buildProductGrid(
      key: ValueKey('baby-$_selectedCategoryIndex'),
      products: _filteredLiveProducts('Baby', liveProducts),
      footerStyle: ProductCardFooterStyle.soldCountAndShipping,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _homeCubit.watchCurrentUser(),
            builder: (context, snapshot) {
              final data = snapshot.data?.data();
              final fallbackName = _homeCubit.displayName.isEmpty
                  ? 'common.default_user'.tr()
                  : _homeCubit.displayName;
              return HomeHeader(
                userName: data?['userName']?.toString() ?? fallbackName,
                avatarImage: data?['avatar']?.toString() ?? '',
              );
            },
          ),
          const SizedBox(height: 18),
          PageTitleSection(
            title: 'home.hero_title'.tr(),
            subtitle: 'home.tagline'.tr(),
          ),
          const SizedBox(height: 16),
          SearchBarWithFilter(
            controller: _searchController,
            readOnly: true,
            onTap: () => context.push(Routes.search),
            onFilterTap: () => context.push(Routes.filter),
          ),
          const SizedBox(height: 20),
          CategoriesSection(
            genderCategories: homeGenderCategories,
            typeCategories: homeTypeCategories,
            selectedGenderIndex: _selectedGenderIndex,
            selectedTypeIndex: _selectedCategoryIndex,
            onGenderSelected: _onGenderSelected,
            onTypeSelected: _onCategorySelected,
            onSeeAll: () => context.push(Routes.categories),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
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
            child: StreamBuilder<List<ProductModel>>(
              stream: _homeCubit.watchProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // TEMP DEBUG: shows the real Firestore error on screen
                  // (e.g. permission-denied) instead of silently falling
                  // back to the hardcoded catalog. Remove once diagnosed.
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Firestore error:\n${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return _buildContent(snapshot.data);
              },
            ),
          ),
        ),
      ),
    );
  }
}

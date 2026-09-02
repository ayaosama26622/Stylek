import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/categories/data/model/categories_option_model.dart';
import 'package:final_project/features/categories/data/repo/categories_repo.dart';
import 'package:final_project/features/categories/domain/usecase/categories_usecases.dart';
import 'package:final_project/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:final_project/features/home/presentation/widgets/search_bar_with_filter.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/features/categories/presentation/widgets/category_grid.dart';
import 'package:final_project/features/categories/presentation/widgets/category_products_grid.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _searchController = TextEditingController();
  late final CategoriesCubit _categoriesCubit;

  List<CategoriesOptionModel> get _categories => _categoriesCubit.options;

  @override
  void initState() {
    super.initState();
    _categoriesCubit = CategoriesCubit(CategoriesUseCases(CategoriesRepo()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(Routes.home);
    }
  }

  void _selectCategory(CategoriesOptionModel category) {
    setState(() => _categoriesCubit.selectCategory(category));
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder<List<ProductModel>>(
                  stream: _categoriesCubit.watchProducts(),
                  builder: (context, snapshot) {
                    final products = _categoriesCubit.filterProducts(
                      snapshot.data ?? [],
                    );
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              AppHeaderBar(
                                title: 'home.categories'.tr(),
                                onBack: _goBack,
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: SearchBarWithFilter(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      _categoriesCubit.updateQuery(value);
                                    });
                                  },
                                  onFilterTap: () =>
                                      context.push(Routes.filter),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: CategoryGrid(
                                  categories: _categories,
                                  selectedCategory:
                                      _categoriesCubit.selectedCategory,
                                  onSelected: _selectCategory,
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                        if (_categoriesCubit.selectedCategory != null ||
                            _categoriesCubit.query.isNotEmpty)
                          CategoryProductsGrid(products: products)
                        else
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: SizedBox(),
                          ),
                        const SliverToBoxAdapter(child: SizedBox(height: 100)),
                      ],
                    );
                  },
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 22,
                  child: AppBottomNavBar(
                    selectedIndex: 0,
                    onTap: (index) {
                      if (index == 0) context.go(Routes.home);
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

import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/filter/data/repo/filter_repo.dart';
import 'package:final_project/features/filter/domain/usecase/filter_usecases.dart';
import 'package:final_project/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:final_project/features/filter/presentation/widgets/filter_chip_wrap.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/features/filter/presentation/widgets/filter_products_grid.dart';
import 'package:final_project/features/filter/presentation/widgets/filter_section.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final FilterCubit _filterCubit;

  @override
  void initState() {
    super.initState();
    _filterCubit = FilterCubit(FilterUseCases(FilterRepo()));
  }

  @override
  void dispose() => super.dispose();

  void _resetFilters() {
    setState(_filterCubit.resetFilters);
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(Routes.home);
    }
  }

  void _selectGender(String value) {
    setState(() => _filterCubit.selectGender(value));
  }

  void _selectCategory(String value) {
    setState(() => _filterCubit.selectCategory(value));
  }

  void _selectColor(String value) {
    setState(() => _filterCubit.selectColor(value));
  }

  void _selectSeason(String value) {
    setState(() => _filterCubit.selectSeason(value));
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
                  stream: _filterCubit.watchProducts(),
                  builder: (context, snapshot) {
                    final products = _filterCubit.filterProducts(
                      snapshot.data ?? [],
                    );
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHeaderBar(
                                title: 'filter.title'.tr(),
                                onBack: _goBack,
                                trailing: GestureDetector(
                                  onTap: _resetFilters,
                                  child: SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Icon(
                                      Icons.restart_alt_rounded,
                                      color: AppColor.onSurface(context),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    FilterSection(
                                      title: 'filter.gender'.tr(),
                                      child: FilterChipWrap(
                                        items: _filterCubit.genderOptions,
                                        selectedValue:
                                            _filterCubit.selectedGender,
                                        onSelected: _selectGender,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    FilterSection(
                                      title: 'filter.category'.tr(),
                                      child: FilterChipWrap(
                                        items: _filterCubit.categoryOptions,
                                        selectedValue:
                                            _filterCubit.selectedCategory,
                                        onSelected: _selectCategory,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    FilterSection(
                                      title: 'filter.color'.tr(),
                                      child: FilterChipWrap(
                                        items: _filterCubit.colorOptions,
                                        selectedValue:
                                            _filterCubit.selectedColor,
                                        onSelected: _selectColor,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    FilterSection(
                                      title: 'filter.season'.tr(),
                                      child: FilterChipWrap(
                                        items: _filterCubit.seasonOptions,
                                        selectedValue:
                                            _filterCubit.selectedSeason,
                                        onSelected: _selectSeason,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    FilterSection(
                                      title:
                                          'Price  EGP ${_filterCubit.priceRange.start.round()} - ${_filterCubit.priceRange.end.round()}',
                                      child: RangeSlider(
                                        min: 0,
                                        max: 2500,
                                        divisions: 25,
                                        values: _filterCubit.priceRange,
                                        activeColor: AppColor.onSurface(
                                          context,
                                        ),
                                        inactiveColor: AppColor.surface(
                                          context,
                                        ),
                                        labels: RangeLabels(
                                          _filterCubit.priceRange.start
                                              .round()
                                              .toString(),
                                          _filterCubit.priceRange.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChanged: (values) {
                                          setState(() {
                                            _filterCubit.updatePriceRange(
                                              values,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      '${products.length} items',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: AppColor.onSurface(context),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FilterProductsGrid(products: products),
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

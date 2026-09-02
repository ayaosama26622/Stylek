import 'package:final_project/core/functions/navigation.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/shimmer/grid_shimmer.dart';
import 'package:final_project/features/filter/presentation/widgets/product_filter_bottom_sheet.dart';
import 'package:final_project/features/search/data/repo/search_repo.dart';
import 'package:final_project/features/search/domain/usecase/search_usecases.dart';
import 'package:final_project/features/search/presentation/cubit/search_cubit.dart';
import 'package:final_project/features/home/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:final_project/features/home/presentation/widgets/product_card.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/presentation/widgets/search_bar_with_filter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../widgets/search_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  late final SearchCubit _searchCubit;
  String _query = '';
  ProductFilterValue _filterValue = const ProductFilterValue();

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(SearchUseCases(SearchRepo()));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchCubit.dispose();
    super.dispose();
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeaderBar(
                      title: 'search.title'.tr(),
                      onBack: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(Routes.home);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchBarWithFilter(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (value) => setState(() => _query = value),
                        onFilterTap: _openFilter,
                        isFilterActive: _filterValue.hasFilters,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _SearchResults(
                          query: _query,
                          searchCubit: _searchCubit,
                          filterValue: _filterValue,
                        ),
                      ),
                    ),
                  ],
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

import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/cart/data/repo/cart_repo.dart';
import 'package:final_project/features/cart/domain/usecase/cart_usecases.dart';
import 'package:final_project/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:final_project/features/cart/presentation/widgets/cart_bottom_panel.dart';
import 'package:final_project/features/cart/presentation/widgets/cart_filter_bottom_sheet.dart';
import 'package:final_project/core/widgets/app_empty_state.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:final_project/features/home/presentation/widgets/search_bar_with_filter.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _searchController = TextEditingController();
  final _discountController = TextEditingController();
  late final CartCubit _cartCubit;
  String _query = '';
  CartFilterValue _filterValue = const CartFilterValue();

  @override
  void initState() {
    super.initState();
    _cartCubit = CartCubit(CartUseCases(CartRepo()));
    _cartCubit.seedCheckoutPricingIfNeeded();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _discountController.dispose();
    _cartCubit.dispose();
    super.dispose();
  }

  List<CartItemModel> _filteredItems(List<CartItemModel> items) {
    final normalizedQuery = _query.trim().toLowerCase();
    return items.where((item) {
      final queryMatches =
          normalizedQuery.isEmpty ||
          item.name.toLowerCase().contains(normalizedQuery) ||
          item.color.toLowerCase().contains(normalizedQuery) ||
          item.size.toLowerCase().contains(normalizedQuery);
      return queryMatches && _filterValue.matches(item);
    }).toList();
  }

  Future<void> _openFilter() async {
    final nextValue = await showCartFilterBottomSheet(
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
              children: [
                AppHeaderBar(title: 'cart.title'.tr(), onBack: widget.onBack),
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
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<CheckoutPricingModel>(
                    stream: _cartCubit.watchPricing(),
                    builder: (context, pricingSnapshot) {
                      final pricing =
                          pricingSnapshot.data ??
                          const CheckoutPricingModel(
                            discountPercent: 15,
                            deliveryFee: 15,
                          );
                      return StreamBuilder<List<CartItemModel>>(
                        stream: _cartCubit.watchItems(),
                        builder: (context, snapshot) {
                          final allItems =
                              snapshot.data ?? const <CartItemModel>[];
                          final items = _filteredItems(allItems);
                          final summary = _cartCubit.buildSummary(
                            allItems,
                            pricing,
                          );
                          return ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              if (allItems.isEmpty)
                                SizedBox(
                                  height: 220,
                                  child: AppEmptyState(
                                    icon: Icons.shopping_cart_outlined,
                                    title: 'cart.empty'.tr(),
                                  ),
                                )
                              else if (items.isEmpty)
                                SizedBox(
                                  height: 220,
                                  child: AppEmptyState(
                                    icon: Icons.filter_alt_off_outlined,
                                    title: 'cart.no_items_found'.tr(),
                                  ),
                                )
                              else
                                ...items.map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: CartItemCard(
                                      item: item,
                                      onDelete: () =>
                                          _cartCubit.removeItem(item.id),
                                      onIncrement: () =>
                                          _cartCubit.increment(item),
                                      onDecrement: () =>
                                          _cartCubit.decrement(item),
                                      onColorChanged: (color) =>
                                          _cartCubit.updateColor(item, color),
                                      onSizeChanged: (size) =>
                                          _cartCubit.updateSize(item, size),
                                    ),
                                  ),
                                ),
                              CartBottomPanel(
                                summary: summary,
                                discountController: _discountController,
                                onCheckout: allItems.isEmpty
                                    ? null
                                    : () => context.push(Routes.checkout),
                              ),
                            ],
                          );
                        },
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

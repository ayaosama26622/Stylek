import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/cart/domain/usecase/cart_usecases.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:flutter/foundation.dart';

class CartCubit extends ChangeNotifier {
  CartCubit(this._useCases);

  final CartUseCases _useCases;

  Stream<List<CartItemModel>> watchItems() => _useCases.watchItems();

  Stream<CheckoutPricingModel> watchPricing() => _useCases.watchPricing();

  Future<void> seedCheckoutPricingIfNeeded() {
    return _useCases.seedCheckoutPricingIfNeeded();
  }

  Future<void> removeItem(String itemId) => _useCases.removeItem(itemId);

  Future<void> increment(CartItemModel item) => _useCases.increment(item);

  Future<void> decrement(CartItemModel item) => _useCases.decrement(item);

  Future<void> updateColor(CartItemModel item, String color) {
    return _useCases.updateColor(item, color);
  }

  Future<void> updateSize(CartItemModel item, String size) {
    return _useCases.updateSize(item, size);
  }

  CartSummaryModel buildSummary(
    List<CartItemModel> items,
    CheckoutPricingModel pricing,
  ) {
    return _useCases.buildSummary(items, pricing);
  }
}

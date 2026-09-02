import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/cart/data/repo/cart_repo.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';

class CartUseCases {
  CartUseCases(this._repo);

  final CartRepo _repo;

  Stream<List<CartItemModel>> watchItems() => _repo.watchCartItems();

  Stream<CheckoutPricingModel> watchPricing() => _repo.watchPricing();

  Future<void> seedCheckoutPricingIfNeeded() {
    return _repo.seedCheckoutPricingIfNeeded();
  }

  Future<void> removeItem(String itemId) => _repo.removeItem(itemId);

  Future<void> increment(CartItemModel item) {
    return _repo.updateQuantity(item.id, item.quantity + 1);
  }

  Future<void> decrement(CartItemModel item) {
    return _repo.updateQuantity(item.id, item.quantity - 1);
  }

  Future<void> updateColor(CartItemModel item, String color) {
    return _repo.updateOptions(itemId: item.id, color: color, size: item.size);
  }

  Future<void> updateSize(CartItemModel item, String size) {
    return _repo.updateOptions(itemId: item.id, color: item.color, size: size);
  }

  CartSummaryModel buildSummary(
    List<CartItemModel> items,
    CheckoutPricingModel pricing,
  ) {
    final subtotal = items.fold<double>(
      0,
      (total, item) => total + item.lineTotal,
    );
    return CartSummaryModel(
      subtotal: subtotal,
      deliveryFee: items.isEmpty ? 0 : pricing.deliveryFee,
      discount: pricing.discountFor(subtotal),
      discountLabel: pricing.discountLabel,
    );
  }
}

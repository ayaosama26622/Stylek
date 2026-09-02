import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';

class CartRepo {
  Stream<List<CartItemModel>> watchCartItems() {
    return FirebaseProvider.cartStream();
  }

  Stream<CheckoutPricingModel> watchPricing() {
    return FirebaseProvider.checkoutPricingStream();
  }

  Future<void> seedCheckoutPricingIfNeeded() {
    return FirebaseProvider.seedCheckoutPricingIfNeeded();
  }

  Future<void> removeItem(String itemId) {
    return FirebaseProvider.removeCartItem(itemId);
  }

  Future<void> updateQuantity(String itemId, int quantity) {
    return FirebaseProvider.updateCartItemQuantity(itemId, quantity);
  }

  Future<void> updateOptions({
    required String itemId,
    required String color,
    required String size,
  }) {
    return FirebaseProvider.updateCartItemOptions(
      itemId: itemId,
      color: color,
      size: size,
    );
  }
}

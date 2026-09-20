import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_order_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';

class CheckoutRepo {
  Stream<List<CartItemModel>> watchCartItems() {
    return FirebaseProvider.cartStream();
  }

  Stream<CheckoutPricingModel> watchPricing() {
    return FirebaseProvider.checkoutPricingStream();
  }

  Future<void> seedCheckoutPricingIfNeeded() {
    return FirebaseProvider.seedCheckoutPricingIfNeeded();
  }

  Future<String> createOrder(CheckoutOrderModel order) {
    return FirebaseProvider.createOrder(
      userName: order.userName,
      phone: order.phone,
      address: order.address,
      paymentMethod: order.paymentMethod,
      items: order.items,
      discountPercent: order.discountPercent,
      deliveryFee: order.deliveryFee,
    );
  }
}

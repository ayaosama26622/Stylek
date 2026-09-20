import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_order_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:final_project/features/checkout/data/repo/checkout_repo.dart';

class CheckoutUseCases {
  CheckoutUseCases(this._repo);

  final CheckoutRepo _repo;

  Stream<List<CartItemModel>> watchCartItems() => _repo.watchCartItems();

  Stream<CheckoutPricingModel> watchPricing() => _repo.watchPricing();

  Future<void> seedCheckoutPricingIfNeeded() {
    return _repo.seedCheckoutPricingIfNeeded();
  }

  Future<String> createCashOrder({
    required String userName,
    required String phone,
    required String address,
    required String paymentMethod,
    required List<CartItemModel> items,
    required CheckoutPricingModel pricing,
  }) {
    return _repo.createOrder(
      CheckoutOrderModel(
        userName: userName,
        phone: phone,
        address: address,
        paymentMethod: paymentMethod,
        items: items,
        discountPercent: pricing.discountPercent,
        deliveryFee: pricing.deliveryFee,
      ),
    );
  }
}

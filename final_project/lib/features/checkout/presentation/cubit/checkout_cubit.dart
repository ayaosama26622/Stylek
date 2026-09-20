import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:final_project/features/checkout/domain/usecase/checkout_usecases.dart';
import 'package:flutter/foundation.dart';

class CheckoutCubit extends ChangeNotifier {
  CheckoutCubit(this._useCases);

  final CheckoutUseCases _useCases;

  Stream<List<CartItemModel>> watchCartItems() => _useCases.watchCartItems();

  Stream<CheckoutPricingModel> watchPricing() => _useCases.watchPricing();

  Future<void> seedCheckoutPricingIfNeeded() {
    return _useCases.seedCheckoutPricingIfNeeded();
  }

  Future<String> createOrder({
    required String userName,
    required String phone,
    required String address,
    required String paymentMethod,
    required List<CartItemModel> items,
    required CheckoutPricingModel pricing,
  }) {
    return _useCases.createCashOrder(
      userName: userName,
      phone: phone,
      address: address,
      paymentMethod: paymentMethod,
      items: items,
      pricing: pricing,
    );
  }
}

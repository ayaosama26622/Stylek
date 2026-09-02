import 'package:final_project/features/cart/data/model/cart_item_model.dart';

class CheckoutOrderModel {
  const CheckoutOrderModel({
    required this.userName,
    required this.phone,
    required this.address,
    required this.paymentMethod,
    required this.items,
    required this.discountPercent,
    required this.deliveryFee,
  });

  final String userName;
  final String phone;
  final String address;
  final String paymentMethod;
  final List<CartItemModel> items;
  final double discountPercent;
  final double deliveryFee;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';

class InvoiceModel {
  const InvoiceModel({
    required this.id,
    required this.userName,
    required this.phone,
    required this.address,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.discountPercent,
    required this.discount,
    required this.total,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String userName;
  final String phone;
  final String address;
  final String paymentMethod;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double discountPercent;
  final double discount;
  final double total;
  final String status;
  final DateTime? createdAt;

  factory InvoiceModel.fromMap(String id, Map<String, dynamic> data) {
    double readDouble(Object? value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? 0;
    }

    final rawItems = data['items'];
    final items = rawItems is List
        ? rawItems
              .whereType<Map>()
              .map(
                (item) => CartItemModel.fromMap(
                  item['id']?.toString() ?? item['productId']?.toString() ?? '',
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
        : const <CartItemModel>[];
    final createdAtValue = data['createdAt'];
    return InvoiceModel(
      id: id,
      userName: data['userName']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      address: data['address']?.toString() ?? '',
      paymentMethod: data['paymentMethod']?.toString() ?? '',
      items: items,
      subtotal: readDouble(data['subtotal']),
      deliveryFee: readDouble(data['deliveryFee']),
      discountPercent: readDouble(data['discountPercent']),
      discount: readDouble(data['discount']),
      total: readDouble(data['total']),
      status: data['status']?.toString() ?? 'pending',
      createdAt: createdAtValue is Timestamp ? createdAtValue.toDate() : null,
    );
  }
}

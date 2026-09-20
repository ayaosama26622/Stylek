import 'package:flutter/material.dart';

class CartItemModel {
  final String id;
  final String name;
  final String nameAr;
  final String image;
  final double unitPrice;
  final String color;
  final String size;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.name,
    this.nameAr = '',
    required this.image,
    required this.unitPrice,
    required this.color,
    required this.size,
    this.quantity = 1,
  });

  String localizedName(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (isArabic && nameAr.trim().isNotEmpty) return nameAr;
    return name;
  }

  factory CartItemModel.fromMap(String id, Map<String, dynamic> data) {
    double readDouble(Object? value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? 0;
    }

    int readInt(Object? value) {
      if (value is num) return value.toInt();
      return int.tryParse(value.toString()) ?? 1;
    }

    return CartItemModel(
      id: id,
      name: data['name']?.toString() ?? '',
      nameAr: data['nameAr']?.toString() ?? '',
      image: data['image']?.toString() ?? 'assets/images/logo.png',
      unitPrice: readDouble(data['unitPrice']),
      color: data['color']?.toString() ?? 'Default',
      size: data['size']?.toString() ?? 'M',
      quantity: readInt(data['quantity']),
    );
  }

  double get lineTotal => unitPrice * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'image': image,
      'unitPrice': unitPrice,
      'color': color,
      'size': size,
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({String? color, String? size, int? quantity}) {
    return CartItemModel(
      id: id,
      name: name,
      nameAr: nameAr,
      image: image,
      unitPrice: unitPrice,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartSummaryModel {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final String discountLabel;

  const CartSummaryModel({
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    this.discountLabel = 'Discount',
  });

  double get total => subtotal + deliveryFee - discount;
}

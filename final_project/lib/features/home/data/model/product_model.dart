import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String nameAr;
  final String image;
  final double price;
  final double? oldPrice;
  final double rating;
  final int soldCount;
  final bool isFavorite;
  final double? shippingFee;
  final String gender;
  final String category;
  final String section;
  final String color;
  final String season;

  const ProductModel({
    this.id = '',
    required this.name,
    this.nameAr = '',
    required this.image,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.soldCount,
    this.isFavorite = false,
    this.shippingFee,
    this.gender = 'Man',
    this.category = 'All',
    this.section = 'Recommended For You',
    this.color = 'Black',
    this.season = 'Summer',
  });

  /// Returns the Arabic name when the app is in Arabic and a translation
  /// exists in Firestore ('nameAr'); otherwise falls back to the English name.
  String localizedName(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (isArabic && nameAr.trim().isNotEmpty) return nameAr;
    return name;
  }

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    double? optionalDouble(Object? value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString());
    }

    double requiredDouble(Object? value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? 0;
    }

    int requiredInt(Object? value) {
      if (value is num) return value.toInt();
      return int.tryParse(value.toString()) ?? 0;
    }

    return ProductModel(
      id: id,
      name: data['name']?.toString() ?? '',
      nameAr: data['nameAr']?.toString() ?? '',
      image: data['image']?.toString() ?? 'assets/images/logo.png',
      price: requiredDouble(data['price']),
      oldPrice: optionalDouble(data['oldPrice']),
      rating: requiredDouble(data['rating']),
      soldCount: requiredInt(data['soldCount']),
      isFavorite: data['isFavorite'] == true,
      shippingFee: optionalDouble(data['shippingFee']),
      gender: data['gender']?.toString() ?? 'Man',
      category: data['category']?.toString() ?? 'All',
      section: data['section']?.toString() ?? 'Recommended For You',
      color: data['color']?.toString() ?? 'Black',
      season: data['season']?.toString() ?? 'Summer',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nameAr': nameAr,
      'image': image,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'soldCount': soldCount,
      'isFavorite': isFavorite,
      'shippingFee': shippingFee,
      'gender': gender,
      'category': category,
      'section': section,
      'color': color,
      'season': season,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? image,
    double? price,
    double? oldPrice,
    double? rating,
    int? soldCount,
    bool? isFavorite,
    double? shippingFee,
    String? gender,
    String? category,
    String? section,
    String? color,
    String? season,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      image: image ?? this.image,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      soldCount: soldCount ?? this.soldCount,
      isFavorite: isFavorite ?? this.isFavorite,
      shippingFee: shippingFee ?? this.shippingFee,
      gender: gender ?? this.gender,
      category: category ?? this.category,
      section: section ?? this.section,
      color: color ?? this.color,
      season: season ?? this.season,
    );
  }
}

import 'package:flutter/material.dart';

class CategoriesOptionModel {
  final String label;
  final IconData? icon;
  final String? imagePath;

  const CategoriesOptionModel({required this.label, this.icon, this.imagePath});
}

const List<CategoriesOptionModel> categoriesOptions = [
  CategoriesOptionModel(label: 'Offers', imagePath: 'assets/images/offers.png'),
  CategoriesOptionModel(label: 'Dress', imagePath: 'assets/images/dress.png'),
  CategoriesOptionModel(label: 'Shirt', imagePath: 'assets/images/Shirt.png'),
  CategoriesOptionModel(label: 'Jacket', imagePath: 'assets/images/Jacket.png'),
  CategoriesOptionModel(label: 'Pants', imagePath: 'assets/images/Pants.png'),
  CategoriesOptionModel(label: 'Shorts', imagePath: 'assets/images/Shorts.png'),
  CategoriesOptionModel(label: 'Jeep', imagePath: 'assets/images/Jeep.png'),
  CategoriesOptionModel(label: 'Bag', imagePath: 'assets/images/Bag.png'),
  CategoriesOptionModel(label: 'Shoes', icon: Icons.hiking_rounded),
];

import 'package:flutter/material.dart';

class FilterOptionModel {
  final String label;
  final IconData? icon;
  final String? imagePath;

  const FilterOptionModel({required this.label, this.icon, this.imagePath});
}

const List<FilterOptionModel> filterGenderOptions = [
  FilterOptionModel(label: 'Man'),
  FilterOptionModel(label: 'Woman'),
  FilterOptionModel(label: 'Baby'),
];

const List<FilterOptionModel> filterCategoryOptions = [
  FilterOptionModel(label: 'All'),
  FilterOptionModel(label: 'Offers', imagePath: 'assets/images/offers.png'),
  FilterOptionModel(label: 'Dress', imagePath: 'assets/images/dress.png'),
  FilterOptionModel(label: 'Shirt', imagePath: 'assets/images/Shirt.png'),
  FilterOptionModel(label: 'Jacket', imagePath: 'assets/images/Jacket.png'),
  FilterOptionModel(label: 'Pants', imagePath: 'assets/images/Pants.png'),
  FilterOptionModel(label: 'Shorts', imagePath: 'assets/images/Shorts.png'),
  FilterOptionModel(label: 'Jeep', imagePath: 'assets/images/Jeep.png'),
  FilterOptionModel(label: 'Bag', imagePath: 'assets/images/Bag.png'),
  FilterOptionModel(label: 'Shoes', icon: Icons.hiking_rounded),
];

const List<FilterOptionModel> filterColorOptions = [
  FilterOptionModel(label: 'Black', icon: Icons.circle),
  FilterOptionModel(label: 'White', icon: Icons.circle_outlined),
  FilterOptionModel(label: 'Pink', icon: Icons.favorite_rounded),
  FilterOptionModel(label: 'Blue', icon: Icons.water_drop_rounded),
  FilterOptionModel(label: 'Brown', icon: Icons.circle),
  FilterOptionModel(label: 'Green', icon: Icons.eco_rounded),
];

const List<FilterOptionModel> filterSeasonOptions = [
  FilterOptionModel(label: 'Summer', icon: Icons.wb_sunny_rounded),
  FilterOptionModel(label: 'Winter', icon: Icons.ac_unit_rounded),
  FilterOptionModel(label: 'Autumn', icon: Icons.park_rounded),
  FilterOptionModel(label: 'Spring', icon: Icons.local_florist_rounded),
];

import 'package:final_project/features/filter/data/model/filter_option_model.dart';
import 'package:final_project/features/filter/data/repo/filter_repo.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';

class FilterUseCases {
  FilterUseCases(this._repo);

  final FilterRepo _repo;

  Future<void> seedDefaultProductsIfNeeded() {
    return _repo.seedDefaultProductsIfNeeded();
  }

  List<FilterOptionModel> get genderOptions => _repo.genderOptions;
  List<FilterOptionModel> get categoryOptions => _repo.categoryOptions;
  List<FilterOptionModel> get colorOptions => _repo.colorOptions;
  List<FilterOptionModel> get seasonOptions => _repo.seasonOptions;

  Stream<List<ProductModel>> watchProducts() => _repo.watchProducts();

  List<ProductModel> filterProducts({
    required List<ProductModel> products,
    required String? selectedGender,
    required String? selectedCategory,
    required String? selectedColor,
    required String? selectedSeason,
    required RangeValues priceRange,
  }) {
    return products.where((product) {
      final matchesGender =
          selectedGender == null ||
          product.gender.toLowerCase() == selectedGender.toLowerCase();
      final matchesCategory =
          selectedCategory == null ||
          selectedCategory == 'All' ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesColor =
          selectedColor == null ||
          product.color.toLowerCase() == selectedColor.toLowerCase();
      final matchesSeason =
          selectedSeason == null ||
          product.season.toLowerCase() == selectedSeason.toLowerCase();
      final matchesPrice =
          product.price >= priceRange.start && product.price <= priceRange.end;
      return matchesGender &&
          matchesCategory &&
          matchesColor &&
          matchesSeason &&
          matchesPrice;
    }).toList();
  }
}

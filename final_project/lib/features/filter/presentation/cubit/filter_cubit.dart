import 'package:final_project/features/filter/data/model/filter_option_model.dart';
import 'package:final_project/features/filter/domain/usecase/filter_usecases.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';

class FilterCubit {
  FilterCubit(this._useCases);

  final FilterUseCases _useCases;

  String? selectedGender;
  String? selectedCategory;
  String? selectedColor;
  String? selectedSeason;
  RangeValues priceRange = const RangeValues(0, 2500);

  List<FilterOptionModel> get genderOptions => _useCases.genderOptions;
  List<FilterOptionModel> get categoryOptions => _useCases.categoryOptions;
  List<FilterOptionModel> get colorOptions => _useCases.colorOptions;
  List<FilterOptionModel> get seasonOptions => _useCases.seasonOptions;

  Future<void> seedDefaultProductsIfNeeded() {
    return _useCases.seedDefaultProductsIfNeeded();
  }

  Stream<List<ProductModel>> watchProducts() => _useCases.watchProducts();

  void resetFilters() {
    selectedGender = null;
    selectedCategory = null;
    selectedColor = null;
    selectedSeason = null;
    priceRange = const RangeValues(0, 2500);
  }

  void selectGender(String value) {
    selectedGender = selectedGender == value ? null : value;
  }

  void selectCategory(String value) {
    selectedCategory = selectedCategory == value ? null : value;
  }

  void selectColor(String value) {
    selectedColor = selectedColor == value ? null : value;
  }

  void selectSeason(String value) {
    selectedSeason = selectedSeason == value ? null : value;
  }

  void updatePriceRange(RangeValues values) {
    priceRange = values;
  }

  List<ProductModel> filterProducts(List<ProductModel> products) {
    return _useCases.filterProducts(
      products: products,
      selectedGender: selectedGender,
      selectedCategory: selectedCategory,
      selectedColor: selectedColor,
      selectedSeason: selectedSeason,
      priceRange: priceRange,
    );
  }
}

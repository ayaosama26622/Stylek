import 'package:final_project/features/categories/data/model/categories_option_model.dart';
import 'package:final_project/features/categories/data/repo/categories_repo.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class CategoriesUseCases {
  CategoriesUseCases(this._repo);

  final CategoriesRepo _repo;

  Future<void> seedDefaultProductsIfNeeded() {
    return _repo.seedDefaultProductsIfNeeded();
  }

  List<CategoriesOptionModel> get options => _repo.options;

  Stream<List<ProductModel>> watchProducts() => _repo.watchProducts();

  List<ProductModel> filterProducts({
    required List<ProductModel> products,
    required String? selectedCategory,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return products.where((product) {
      final matchesCategory =
          selectedCategory == null ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch =
          normalizedQuery.isEmpty ||
          product.name.toLowerCase().contains(normalizedQuery) ||
          product.category.toLowerCase().contains(normalizedQuery) ||
          product.gender.toLowerCase().contains(normalizedQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}

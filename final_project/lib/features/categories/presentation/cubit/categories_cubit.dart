import 'package:final_project/features/categories/data/model/categories_option_model.dart';
import 'package:final_project/features/categories/domain/usecase/categories_usecases.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class CategoriesCubit {
  CategoriesCubit(this._useCases);

  final CategoriesUseCases _useCases;

  String? selectedCategory;
  String query = '';

  List<CategoriesOptionModel> get options => _useCases.options;

  Future<void> seedDefaultProductsIfNeeded() {
    return _useCases.seedDefaultProductsIfNeeded();
  }

  Stream<List<ProductModel>> watchProducts() => _useCases.watchProducts();

  void updateQuery(String value) {
    query = value;
  }

  void selectCategory(CategoriesOptionModel category) {
    selectedCategory = selectedCategory == category.label
        ? null
        : category.label;
  }

  List<ProductModel> filterProducts(List<ProductModel> products) {
    return _useCases.filterProducts(
      products: products,
      selectedCategory: selectedCategory,
      query: query,
    );
  }
}

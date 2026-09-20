import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/categories/data/model/categories_option_model.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class CategoriesRepo {
  Future<void> seedDefaultProductsIfNeeded() {
    return FirebaseProvider.seedDefaultProductsIfNeeded();
  }

  List<CategoriesOptionModel> get options => categoriesOptions;

  Stream<List<ProductModel>> watchProducts() {
    return FirebaseProvider.productsStream();
  }
}

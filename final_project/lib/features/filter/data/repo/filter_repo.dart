import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/filter/data/model/filter_option_model.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class FilterRepo {
  Future<void> seedDefaultProductsIfNeeded() {
    return FirebaseProvider.seedDefaultProductsIfNeeded();
  }

  List<FilterOptionModel> get genderOptions => filterGenderOptions;
  List<FilterOptionModel> get categoryOptions => filterCategoryOptions;
  List<FilterOptionModel> get colorOptions => filterColorOptions;
  List<FilterOptionModel> get seasonOptions => filterSeasonOptions;

  Stream<List<ProductModel>> watchProducts() {
    return FirebaseProvider.productsStream();
  }
}

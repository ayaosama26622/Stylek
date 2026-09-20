import 'package:final_project/features/home/data/model/product_model.dart';

class FavoritesModel {
  const FavoritesModel(this.products);

  final List<ProductModel> products;

  bool get isEmpty => products.isEmpty;
}

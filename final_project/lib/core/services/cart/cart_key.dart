import 'package:final_project/features/home/data/model/product_model.dart';

/// The Firestore key used to identify a product inside the current user's
/// cart. Kept as a single shared function so every screen agrees on the
/// same key for the same product (mirrors [favoriteKeyFor]).
String cartKeyFor(ProductModel product) {
  return product.id.isEmpty ? product.name : product.id;
}

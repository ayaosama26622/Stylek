import 'package:final_project/features/home/data/model/product_model.dart';

/// The Firestore key used to identify a product inside the current user's
/// favorites collection. Kept as a single shared function so every screen
/// (product cards, product details, favorites list) agrees on the same key
/// for the same product — this is what keeps the heart icon in sync
/// everywhere.
String favoriteKeyFor(ProductModel product) {
  return product.id.isEmpty ? product.name : product.id;
}

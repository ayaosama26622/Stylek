import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class HomeRepo {
  Future<void> seedDefaultProductsIfNeeded() {
    return FirebaseProvider.seedDefaultProductsIfNeeded();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return FirebaseProvider.currentUserStream();
  }

  String get displayName => FirebaseProvider.currentUser?.displayName ?? '';

  Stream<List<ProductModel>> watchProducts() {
    return FirebaseProvider.productsStream();
  }

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return FirebaseProvider.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart(ProductModel product) {
    return FirebaseProvider.addToCart(product: product);
  }

  Future<void> removeFromCart(ProductModel product) {
    final itemId = product.id.isEmpty ? product.name : product.id;
    return FirebaseProvider.removeCartItem(itemId);
  }
}

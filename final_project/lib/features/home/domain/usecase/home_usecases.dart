import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/data/repo/home_repo.dart';

class HomeUseCases {
  HomeUseCases(this._repo);

  final HomeRepo _repo;

  Future<void> seedDefaultProductsIfNeeded() {
    return _repo.seedDefaultProductsIfNeeded();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return _repo.watchCurrentUser();
  }

  String get displayName => _repo.displayName;

  Stream<List<ProductModel>> watchProducts() => _repo.watchProducts();

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return _repo.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart(ProductModel product) => _repo.addToCart(product);

  Future<void> removeFromCart(ProductModel product) {
    return _repo.removeFromCart(product);
  }
}

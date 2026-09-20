import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/domain/usecase/home_usecases.dart';
import 'package:flutter/foundation.dart';

class HomeCubit extends ChangeNotifier {
  HomeCubit(this._useCases);

  final HomeUseCases _useCases;

  Future<void> seedDefaultProductsIfNeeded() {
    return _useCases.seedDefaultProductsIfNeeded();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return _useCases.watchCurrentUser();
  }

  String get displayName => _useCases.displayName;

  Stream<List<ProductModel>> watchProducts() => _useCases.watchProducts();

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return _useCases.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart(ProductModel product) => _useCases.addToCart(product);

  Future<void> removeFromCart(ProductModel product) {
    return _useCases.removeFromCart(product);
  }
}

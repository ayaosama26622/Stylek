import 'dart:async';

import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:flutter/foundation.dart';

/// Single shared source of truth for "which products are in the cart".
///
/// Every "Add to Cart" button (product cards, product details) listens to
/// this instead of keeping its own local bool — so adding/removing a
/// product from anywhere is reflected everywhere else immediately.
class CartIdsController extends ChangeNotifier {
  CartIdsController._internal() {
    _subscription = FirebaseProvider.cartIdsStream().listen((ids) {
      _ids = ids;
      notifyListeners();
    });
  }

  static final CartIdsController instance = CartIdsController._internal();

  Set<String> _ids = {};
  StreamSubscription<Set<String>>? _subscription;

  bool isInCart(String productId) => _ids.contains(productId);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

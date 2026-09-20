import 'dart:async';

import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:flutter/foundation.dart';

/// Single shared source of truth for "which products are favorited".
///
/// Every screen that shows a heart icon (Home, Categories, Search, Filter,
/// Product Details, Favorites) listens to this instead of keeping its own
/// local bool — so favoriting a product from anywhere is reflected
/// everywhere else immediately, and un-favoriting clears the heart
/// everywhere too.
class FavoriteIdsController extends ChangeNotifier {
  FavoriteIdsController._internal() {
    _subscription = FirebaseProvider.favoriteIdsStream().listen((ids) {
      _ids = ids;
      notifyListeners();
    });
  }

  static final FavoriteIdsController instance =
      FavoriteIdsController._internal();

  Set<String> _ids = {};
  StreamSubscription<Set<String>>? _subscription;

  bool isFavorite(String productId) => _ids.contains(productId);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

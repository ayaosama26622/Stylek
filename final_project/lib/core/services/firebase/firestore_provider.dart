import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/services/local/shared_pref.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/home/data/model/home_catalog_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final usersCollection = _firestore.collection('users');
  static final productsCollection = _firestore.collection('products');
  static final cartsCollection = _firestore.collection('carts');
  static final favoritesCollection = _firestore.collection('favorites');
  static final ordersCollection = _firestore.collection('orders');
  static final appSettingsCollection = _firestore.collection('app_settings');

  static User? get currentUser => _auth.currentUser;
  static String get currentUserId => currentUser?.uid ?? SharedPref.getUserId();

  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  static Future<UserCredential> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = credential.user;
    if (user == null) return credential;

    await user.updateDisplayName(userName.trim());
    await SharedPref.cacheUserId(user.uid);
    await usersCollection.doc(user.uid).set({
      'uid': user.uid,
      'userName': userName.trim(),
      'email': email.trim(),
      'avatar': '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return credential;
  }

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user?.uid;
    if (uid != null) await SharedPref.cacheUserId(uid);
    return credential;
  }

  static Future<void> signOut() async {
    await SharedPref.removeData(SharedPref.kUserId);
    await _auth.signOut();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> currentUserStream() {
    return usersCollection.doc(currentUserId).snapshots();
  }

  static Stream<List<ProductModel>> productsStream() {
    return productsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// Seeds the default product catalog ONLY the very first time the app
  /// runs against a Firestore project (i.e. when the `products` collection
  /// is completely empty). This is intentionally a one-shot operation:
  /// once you have real data in Firestore (or you've edited a seeded
  /// product from the console), this function must never touch it again,
  /// otherwise any manual edit made in the Firebase console would keep
  /// getting silently overwritten back to the hardcoded values in
  /// `home_catalog_model.dart` on the next app launch.
  static Future<void> seedDefaultProductsIfNeeded() async {
    // If the collection already has ANY documents, assume it has already
    // been seeded (or is being managed manually) and do nothing.
    final existing = await productsCollection.limit(1).get();
    if (existing.docs.isNotEmpty) return;

    final batch = _firestore.batch();
    final uniqueSeedProducts = <String, ProductModel>{};
    for (final product in firebaseSeedProducts) {
      uniqueSeedProducts.putIfAbsent(_seedKey(product), () => product);
    }

    for (final product in uniqueSeedProducts.values) {
      final seedKey = _seedKey(product);
      final ref = productsCollection.doc(seedKey);
      final data = {
        ...product.copyWith(id: ref.id).toMap(),
        'seedKey': seedKey,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      batch.set(ref, data);
    }
    await batch.commit();
  }

  static String _seedKey(ProductModel product) {
    final raw = product.image.trim().isEmpty ? product.name : product.image;
    return raw
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9]+"), '-')
        .replaceAll(RegExp(r"(^-|-$)"), '');
  }

  static Stream<List<CartItemModel>> cartStream() {
    if (currentUserId.isEmpty) return Stream.value(const []);
    return cartsCollection
        .doc(currentUserId)
        .collection('items')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CartItemModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  static Stream<CheckoutPricingModel> checkoutPricingStream() {
    return appSettingsCollection.doc('checkout').snapshots().map((snapshot) {
      return CheckoutPricingModel.fromMap(snapshot.data());
    });
  }

  static Future<void> seedCheckoutPricingIfNeeded() async {
    final ref = appSettingsCollection.doc('checkout');
    final snapshot = await ref.get();
    if (snapshot.exists) return;
    await ref.set({
      'discountPercent': 15,
      'deliveryFee': 15,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<ProductModel>> searchProductsStream(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    return productsStream().map((products) {
      if (normalizedQuery.isEmpty) return const <ProductModel>[];
      return products.where((product) {
        return product.name.toLowerCase().contains(normalizedQuery) ||
            product.category.toLowerCase().contains(normalizedQuery) ||
            product.gender.toLowerCase().contains(normalizedQuery) ||
            product.section.toLowerCase().contains(normalizedQuery);
      }).toList();
    });
  }

  static Future<void> addToCart({
    required ProductModel product,
    String color = 'Default',
    String size = 'M',
    int quantity = 1,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    final itemId = product.id.isEmpty ? product.name : product.id;
    final itemRef = cartsCollection
        .doc(currentUserId)
        .collection('items')
        .doc(itemId);
    final item = await itemRef.get();
    final oldQuantity = item.data()?['quantity'];
    await itemRef.set({
      'productId': product.id,
      'name': product.name,
      'nameAr': product.nameAr,
      'image': product.image,
      'unitPrice': product.price,
      'color': color,
      'size': size,
      'quantity': (oldQuantity is num ? oldQuantity.toInt() : 0) + quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> updateCurrentUserAvatar(String avatarUrl) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    await usersCollection.doc(currentUserId).set({
      'avatar': avatarUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> _reauthenticate(String currentPassword) async {
    final user = currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      throw Exception('common.please_sign_in'.tr());
    }
    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
  }

  static Future<void> updateCurrentUserName(String name) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    await currentUser?.updateDisplayName(name.trim());
    await usersCollection.doc(currentUserId).set({
      'userName': name.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> updateCurrentUserEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    await _reauthenticate(currentPassword);
    await currentUser?.verifyBeforeUpdateEmail(newEmail.trim());
    await usersCollection.doc(currentUserId).set({
      'email': newEmail.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    await _reauthenticate(currentPassword);
    await currentUser?.updatePassword(newPassword);
  }

  static Stream<List<ProductReviewModel>> productReviewsStream(
    String productId,
  ) {
    if (productId.isEmpty) return Stream.value(const []);
    return productsCollection
        .doc(productId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductReviewModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  static Future<void> addProductReview({
    required String productId,
    required ProductReviewModel review,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    if (productId.isEmpty) throw Exception('common.product_not_saved_yet'.tr());
    await productsCollection.doc(productId).collection('reviews').add({
      ...review.toMap(),
      'userId': currentUserId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateProductReviewRating({
    required String productId,
    required String reviewId,
    required int rating,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    if (productId.isEmpty || reviewId.isEmpty) return;
    await productsCollection
        .doc(productId)
        .collection('reviews')
        .doc(reviewId)
        .update({'rating': rating});
  }

  static Future<void> updateProductReviewLikes({
    required String productId,
    required String reviewId,
    required int likes,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    if (productId.isEmpty || reviewId.isEmpty) return;
    await productsCollection
        .doc(productId)
        .collection('reviews')
        .doc(reviewId)
        .update({'likes': likes < 0 ? 0 : likes});
  }

  static Future<void> updateCartItemQuantity(
    String itemId,
    int quantity,
  ) async {
    if (currentUserId.isEmpty) return;
    final itemRef = cartsCollection
        .doc(currentUserId)
        .collection('items')
        .doc(itemId);
    if (quantity <= 0) {
      await itemRef.delete();
      return;
    }
    await itemRef.update({'quantity': quantity});
  }

  static Future<void> updateCartItemOptions({
    required String itemId,
    required String color,
    required String size,
  }) async {
    if (currentUserId.isEmpty) return;
    await cartsCollection
        .doc(currentUserId)
        .collection('items')
        .doc(itemId)
        .update({
          'color': color,
          'size': size,
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  static Future<void> removeCartItem(String itemId) async {
    if (currentUserId.isEmpty) return;
    await cartsCollection
        .doc(currentUserId)
        .collection('items')
        .doc(itemId)
        .delete();
  }

  static Stream<Set<String>> favoriteIdsStream() {
    if (currentUserId.isEmpty) return Stream.value(<String>{});
    return favoritesCollection
        .doc(currentUserId)
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toSet());
  }

  static Future<void> toggleFavorite(
    ProductModel product,
    bool isFavorite,
  ) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    final productId = product.id.isEmpty ? product.name : product.id;
    final favoriteRef = favoritesCollection
        .doc(currentUserId)
        .collection('items')
        .doc(productId);
    if (isFavorite) {
      await favoriteRef.set({
        ...product.copyWith(id: productId, isFavorite: true).toMap(),
        'productId': productId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await favoriteRef.delete();
    }
  }

  static Stream<List<ProductModel>> favoritesStream() {
    if (currentUserId.isEmpty) return Stream.value(const []);
    return favoritesCollection
        .doc(currentUserId)
        .collection('items')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> orderStream(
    String orderId,
  ) {
    return ordersCollection.doc(orderId).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> myOrdersStream() {
    if (currentUserId.isEmpty) return const Stream.empty();
    return ordersCollection
        .where('userId', isEqualTo: currentUserId)
        .snapshots();
  }

  static Future<String> createOrder({
    required String userName,
    required String phone,
    required String address,
    required String paymentMethod,
    required List<CartItemModel> items,
    required double discountPercent,
    required double deliveryFee,
  }) async {
    if (currentUserId.isEmpty) throw Exception('common.please_sign_in'.tr());
    final subtotal = items.fold<double>(
      0,
      (total, item) => total + item.lineTotal,
    );
    final discount = subtotal * discountPercent / 100;
    final orderRef = await ordersCollection.add({
      'userId': currentUserId,
      'userName': userName.trim(),
      'phone': phone.trim(),
      'address': address.trim(),
      'paymentMethod': paymentMethod,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'discountPercent': discountPercent,
      'discount': discount,
      'total': subtotal + deliveryFee - discount,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    final cartItems = await cartsCollection
        .doc(currentUserId)
        .collection('items')
        .get();
    final batch = _firestore.batch();
    for (final item in cartItems.docs) {
      batch.delete(item.reference);
    }
    await batch.commit();
    return orderRef.id;
  }
}

import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class DetailsRepo {
  String get displayName => FirebaseProvider.currentUser?.displayName ?? '';

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return FirebaseProvider.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart({
    required ProductModel product,
    required String color,
    required String size,
    required int quantity,
  }) {
    return FirebaseProvider.addToCart(
      product: product,
      color: color,
      size: size,
      quantity: quantity,
    );
  }

  Stream<List<ProductReviewModel>> watchReviews(String productId) {
    return FirebaseProvider.productReviewsStream(productId);
  }

  Future<void> addReview({
    required String productId,
    required ProductReviewModel review,
  }) {
    return FirebaseProvider.addProductReview(
      productId: productId,
      review: review,
    );
  }

  Future<void> updateReviewRating({
    required String productId,
    required String reviewId,
    required int rating,
  }) {
    return FirebaseProvider.updateProductReviewRating(
      productId: productId,
      reviewId: reviewId,
      rating: rating,
    );
  }

  Future<void> updateReviewLikes({
    required String productId,
    required String reviewId,
    required int likes,
  }) {
    return FirebaseProvider.updateProductReviewLikes(
      productId: productId,
      reviewId: reviewId,
      likes: likes,
    );
  }
}

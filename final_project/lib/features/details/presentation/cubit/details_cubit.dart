import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/details/domain/usecase/details_usecases.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:flutter/foundation.dart';

class DetailsCubit extends ChangeNotifier {
  DetailsCubit(this._useCases);

  final DetailsUseCases _useCases;

  String get displayName => _useCases.displayName;

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return _useCases.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart({
    required ProductModel product,
    required String color,
    required String size,
    required int quantity,
  }) {
    return _useCases.addToCart(
      product: product,
      color: color,
      size: size,
      quantity: quantity,
    );
  }

  Stream<List<ProductReviewModel>> watchReviews(String productId) {
    return _useCases.watchReviews(productId);
  }

  Future<void> addReview({
    required String productId,
    required ProductReviewModel review,
  }) {
    return _useCases.addReview(productId: productId, review: review);
  }

  Future<void> updateReviewRating({
    required String productId,
    required ProductReviewModel review,
    required int rating,
  }) {
    return _useCases.updateReviewRating(
      productId: productId,
      reviewId: review.id,
      rating: rating,
    );
  }

  Future<void> toggleReviewLike({
    required String productId,
    required ProductReviewModel review,
  }) {
    return _useCases.updateReviewLikes(
      productId: productId,
      reviewId: review.id,
      likes: review.likes + 1,
    );
  }

  Future<void> setReviewLiked({
    required String productId,
    required ProductReviewModel review,
    required bool isLiked,
  }) {
    final nextLikes = isLiked ? review.likes + 1 : review.likes - 1;
    return _useCases.updateReviewLikes(
      productId: productId,
      reviewId: review.id,
      likes: nextLikes < 0 ? 0 : nextLikes,
    );
  }
}

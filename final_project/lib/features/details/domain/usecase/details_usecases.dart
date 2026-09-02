import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/details/data/repo/details_repo.dart';
import 'package:final_project/features/home/data/model/product_model.dart';

class DetailsUseCases {
  DetailsUseCases(this._repo);

  final DetailsRepo _repo;

  String get displayName => _repo.displayName;

  Future<void> toggleFavorite(ProductModel product, bool isFavorite) {
    return _repo.toggleFavorite(product, isFavorite);
  }

  Future<void> addToCart({
    required ProductModel product,
    required String color,
    required String size,
    required int quantity,
  }) {
    return _repo.addToCart(
      product: product,
      color: color,
      size: size,
      quantity: quantity,
    );
  }

  Stream<List<ProductReviewModel>> watchReviews(String productId) {
    return _repo.watchReviews(productId);
  }

  Future<void> addReview({
    required String productId,
    required ProductReviewModel review,
  }) {
    return _repo.addReview(productId: productId, review: review);
  }

  Future<void> updateReviewRating({
    required String productId,
    required String reviewId,
    required int rating,
  }) {
    return _repo.updateReviewRating(
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
    return _repo.updateReviewLikes(
      productId: productId,
      reviewId: reviewId,
      likes: likes,
    );
  }
}

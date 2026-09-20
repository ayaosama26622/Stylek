import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/details/presentation/cubit/details_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class ProductReviewCard extends StatefulWidget {
  const ProductReviewCard({
    super.key,
    required this.review,
    required this.productId,
    required this.detailsCubit,
  });

  final ProductReviewModel review;
  final String productId;
  final DetailsCubit detailsCubit;

  @override
  State<ProductReviewCard> createState() => _ProductReviewCardState();
}

class _ProductReviewCardState extends State<ProductReviewCard> {
  late int _rating = widget.review.rating;
  late int _likes = widget.review.likes;
  bool _isLiked = false;

  Future<void> _rate(int newRating) async {
    if (newRating == _rating) return;
    final previousRating = _rating;
    setState(() => _rating = newRating);
    try {
      await widget.detailsCubit.updateReviewRating(
        productId: widget.productId,
        review: widget.review,
        rating: newRating,
      );
    } catch (error) {
      if (mounted) {
        setState(() => _rating = previousRating);
        showErrorSnackBar(context, error.toString());
      }
    }
  }

  Future<void> _toggleLike() async {
    final nextIsLiked = !_isLiked;
    final previousLikes = _likes;
    setState(() {
      _isLiked = nextIsLiked;
      _likes = nextIsLiked ? _likes + 1 : (_likes - 1).clamp(0, 1 << 30);
    });
    try {
      await widget.detailsCubit.setReviewLiked(
        productId: widget.productId,
        review: widget.review,
        isLiked: nextIsLiked,
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLiked = !nextIsLiked;
          _likes = previousLikes;
        });
        showErrorSnackBar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final review = widget.review;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkColor(context).withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review.userName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColor.onSurface(context),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                review.date,
                style: TextStyle(fontSize: 8, color: AppColor.mutedOnCard(context)),
              ),
            ],
          ),
          const SizedBox(height: 4),

          _StarRating(rating: _rating, onRate: _rate),
          const SizedBox(height: 4),

          Text(
            'details.review_options'.tr(
              namedArgs: {
                'color': translateOptionLabel(review.color),
                'size': review.size,
              },
            ),
            style: TextStyle(
              fontSize: 12,
              color: AppColor.onSurface(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'details.comment_label'.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColor.onSurface(context),
                  ),
                ),
                TextSpan(
                  text: review.comment,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.mutedOnCard(context),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Text(
                'details.translate'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColor.onSurface(context).withValues(alpha: 0.7),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toggleLike,
                child: Row(
                  children: [
                    Icon(
                      _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 16,
                      color: _isLiked ? AppColor.blue : AppColor.mutedOnCard(context),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$_likes',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColor.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating, required this.onRate});

  final int rating;
  final ValueChanged<int> onRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRate(index + 1),
          child: Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Icon(
              index < rating ? Icons.star : Icons.star_border,
              size: 14,
              color: index < rating ? Colors.amber : AppColor.mutedOnCard(context),
            ),
          ),
        );
      }),
    );
  }
}

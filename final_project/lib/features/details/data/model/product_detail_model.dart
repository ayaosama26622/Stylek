import 'package:final_project/features/home/data/model/product_model.dart';

class ProductColorOption {
  final String label;
  final String image;
  final int cartCount;

  const ProductColorOption({
    required this.label,
    required this.image,
    this.cartCount = 0,
  });
}

class ProductReviewModel {
  final String id;
  final String userName;
  final String date;
  final int rating;
  final String color;
  final String size;
  final String comment;
  final int likes;

  const ProductReviewModel({
    this.id = '',
    required this.userName,
    required this.date,
    required this.rating,
    required this.color,
    required this.size,
    required this.comment,
    required this.likes,
  });

  factory ProductReviewModel.fromMap(String id, Map<String, dynamic> data) {
    int readInt(Object? value) {
      if (value is num) return value.toInt();
      return int.tryParse(value.toString()) ?? 0;
    }

    return ProductReviewModel(
      id: id,
      userName: data['userName']?.toString() ?? 'User',
      date: data['date']?.toString() ?? '',
      rating: readInt(data['rating']),
      color: data['color']?.toString() ?? '',
      size: data['size']?.toString() ?? '',
      comment: data['comment']?.toString() ?? '',
      likes: readInt(data['likes']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'date': date,
      'rating': rating,
      'color': color,
      'size': size,
      'comment': comment,
      'likes': likes,
    };
  }
}

class ProductDetailModel {
  final ProductModel product;
  final List<String> sizes;
  final List<ProductColorOption> colors;
  final List<String> galleryImages;
  final List<ProductReviewModel> reviews;

  const ProductDetailModel({
    required this.product,
    required this.sizes,
    required this.colors,
    required this.galleryImages,
    required this.reviews,
  });

  factory ProductDetailModel.fromProduct(ProductModel product) {
    return ProductDetailModel(
      product: product,
      sizes: const ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      colors: [
        ProductColorOption(label: 'Navy', image: product.image),
        ProductColorOption(label: 'Black', image: product.image),
        ProductColorOption(label: 'Brown', image: product.image),
      ],
      galleryImages: [product.image, product.image, product.image],
      reviews: _defaultReviews,
    );
  }

  static const List<ProductReviewModel> _defaultReviews = [
    ProductReviewModel(
      userName: 'Aya',
      date: '1 July, 2024',
      rating: 2,
      color: 'Red',
      size: 'L',

      comment: 'The coat is very nice and the material is very wonderful.',
      likes: 55,
    ),
    ProductReviewModel(
      userName: 'Mohamed',
      date: '6 July, 2024',
      rating: 3,
      color: 'White and navy blue',
      size: 'M',
      comment: 'This coat is very beautiful, I ordered it twice.',
      likes: 65,
    ),
  ];

  static ProductDetailModel mensJacketDemo() {
    return ProductDetailModel.fromProduct(
      const ProductModel(
        name: "Men's jacket",
        nameAr: 'جاكيت رجالي',
        image: 'assets/images/new2.png',
        price: 1200,
        oldPrice: 1800,
        rating: 4.5,
        soldCount: 25000,
        shippingFee: 25,
      ),
    );
  }
}

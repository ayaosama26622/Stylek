import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class CheckoutPricingModel {
  const CheckoutPricingModel({
    required this.discountPercent,
    required this.deliveryFee,
  });

  final double discountPercent;
  final double deliveryFee;

  factory CheckoutPricingModel.fromMap(Map<String, dynamic>? data) {
    double readDouble(Object? value, double fallback) {
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? fallback;
    }

    return CheckoutPricingModel(
      discountPercent: readDouble(data?['discountPercent'], 15),
      deliveryFee: readDouble(data?['deliveryFee'], 15),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'discountPercent': discountPercent,
      'deliveryFee': deliveryFee,
    };
  }

  String get discountLabel => 'invoice.discount'.tr(
    namedArgs: {'percent': discountPercent.toStringAsFixed(0)},
  );

  double discountFor(double subtotal) => subtotal * discountPercent / 100;
}

import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/details/data/model/product_detail_model.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacement(BuildContext context, String route, {Object? extra}) {
  return context.pushReplacement(route, extra: extra);
}

Future pushTo(BuildContext context, String route, {Object? extra}) {
  return context.push(route, extra: extra);
}

void pushToBase(BuildContext context, String route, {Object? extra}) {
  return context.go(route, extra: extra);
}

void pop(BuildContext context) {
  context.pop();
}

void openProductDetails(BuildContext context, ProductModel product) {
  context.push(
    Routes.productDetails,
    extra: ProductDetailModel.fromProduct(product),
  );
}

import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/search/domain/usecase/search_usecases.dart';
import 'package:flutter/foundation.dart';

class SearchCubit extends ChangeNotifier {
  SearchCubit(this._useCases);

  final SearchUseCases _useCases;

  Stream<List<ProductModel>> searchProducts(String query) {
    return _useCases.searchProducts(query);
  }
}

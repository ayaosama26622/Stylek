import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/search/data/model/search_query_model.dart';
import 'package:final_project/features/search/data/repo/search_repo.dart';

class SearchUseCases {
  SearchUseCases(this._repo);

  final SearchRepo _repo;

  Stream<List<ProductModel>> searchProducts(String query) {
    return _repo.searchProducts(SearchQueryModel(query));
  }
}

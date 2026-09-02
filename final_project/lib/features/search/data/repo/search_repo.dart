import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/home/data/model/product_model.dart';
import 'package:final_project/features/search/data/model/search_query_model.dart';

class SearchRepo {
  Stream<List<ProductModel>> searchProducts(SearchQueryModel query) {
    return FirebaseProvider.searchProductsStream(query.normalized);
  }
}

import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/favorites/data/model/favorites_model.dart';

class FavoritesRepo {
  Stream<FavoritesModel> watchFavorites() {
    return FirebaseProvider.favoritesStream().map(FavoritesModel.new);
  }
}

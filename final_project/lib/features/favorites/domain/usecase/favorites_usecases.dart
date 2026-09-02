import 'package:final_project/features/favorites/data/model/favorites_model.dart';
import 'package:final_project/features/favorites/data/repo/favorites_repo.dart';

class FavoritesUseCases {
  FavoritesUseCases(this._repo);

  final FavoritesRepo _repo;

  Stream<FavoritesModel> watchFavorites() => _repo.watchFavorites();
}

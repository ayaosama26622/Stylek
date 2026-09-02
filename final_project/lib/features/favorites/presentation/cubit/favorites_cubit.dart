import 'package:final_project/features/favorites/data/model/favorites_model.dart';
import 'package:final_project/features/favorites/domain/usecase/favorites_usecases.dart';
import 'package:flutter/foundation.dart';

class FavoritesCubit extends ChangeNotifier {
  FavoritesCubit(this._useCases);

  final FavoritesUseCases _useCases;

  Stream<FavoritesModel> watchFavorites() => _useCases.watchFavorites();
}

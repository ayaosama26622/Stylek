import 'package:final_project/features/intro/data/model/intro_navigation_model.dart';
import 'package:final_project/features/intro/domain/usecase/intro_usecases.dart';
import 'package:flutter/foundation.dart';

class SplashCubit extends ChangeNotifier {
  SplashCubit(this._useCases);

  final IntroUseCases _useCases;

  IntroNavigationModel nextNavigation() => _useCases.nextNavigation();
}

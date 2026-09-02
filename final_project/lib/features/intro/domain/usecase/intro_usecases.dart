import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/intro/data/model/intro_navigation_model.dart';
import 'package:final_project/features/intro/data/repo/intro_repo.dart';

class IntroUseCases {
  IntroUseCases(this._repo);

  final IntroRepo _repo;

  IntroNavigationModel nextNavigation() {
    if (_repo.hasCurrentUser) return IntroNavigationModel(Routes.home);
    if (_repo.isOnboardingShown()) {
      return IntroNavigationModel(Routes.login);
    }
    return IntroNavigationModel(Routes.onboarding);
  }

  Future<void> completeOnboarding() async {
    await _repo.setOnboardingShown();
  }
}

import 'package:final_project/features/intro/domain/usecase/intro_usecases.dart';
import 'package:flutter/foundation.dart';

class OnboardingCubit extends ChangeNotifier {
  OnboardingCubit(this._useCases);

  final IntroUseCases _useCases;

  Future<void> completeOnboarding() async {
    await _useCases.completeOnboarding();
  }
}

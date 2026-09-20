import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/core/services/local/shared_pref.dart';

class IntroRepo {
  bool get hasCurrentUser => FirebaseProvider.currentUser != null;

  bool isOnboardingShown() => SharedPref.isOnboardingShown();

  Future<bool> setOnboardingShown() => SharedPref.setOnboardingShown();
}

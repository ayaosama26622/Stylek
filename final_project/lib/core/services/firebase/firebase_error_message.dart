import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_auth/firebase_auth.dart';

String firebaseErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'configuration-not-found' || 'unknown' =>
        'Firebase Authentication is not enabled. Open Firebase Console > Authentication > Sign-in method and enable Email/Password.',
      'email-already-in-use' => 'auth.email_already_in_use'.tr(),
      'invalid-email' => 'auth.invalid_email_address'.tr(),
      'weak-password' => 'auth.weak_password'.tr(),
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'auth.wrong_credentials'.tr(),
      'network-request-failed' => 'auth.network_error'.tr(),
      _ => error.message ?? error.toString(),
    };
  }

  if (error is FirebaseException && error.code == 'permission-denied') {
    return 'Firestore rules are blocking this action. Open Firestore > Rules and allow authenticated users to read/write.';
  }

  final message = error.toString();
  if (message.contains('permission-denied')) {
    return 'Firestore rules are blocking this action. Open Firestore > Rules and allow authenticated users to read/write.';
  }
  if (message.contains('CONFIGURATION_NOT_FOUND')) {
    return 'Firebase Authentication is not enabled. Open Firebase Console > Authentication > Sign-in method and enable Email/Password.';
  }
  return message;
}

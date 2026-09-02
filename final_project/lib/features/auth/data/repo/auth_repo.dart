import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/auth/data/model/auth_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  Future<UserCredential> signIn(SignInRequestModel request) {
    return FirebaseProvider.signIn(
      email: request.email,
      password: request.password,
    );
  }

  Future<UserCredential> signUp(SignUpRequestModel request) {
    return FirebaseProvider.signUp(
      userName: request.userName,
      email: request.email,
      password: request.password,
    );
  }

  Future<void> signOut() => FirebaseProvider.signOut();

  Future<void> seedDefaultProductsIfNeeded() {
    return FirebaseProvider.seedDefaultProductsIfNeeded();
  }
}

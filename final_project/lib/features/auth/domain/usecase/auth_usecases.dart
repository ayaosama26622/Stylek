import 'package:final_project/features/auth/data/model/auth_request_model.dart';
import 'package:final_project/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUseCases {
  AuthUseCases(this._repo);

  final AuthRepo _repo;

  Future<UserCredential> signIn(SignInRequestModel request) {
    return _repo.signIn(request);
  }

  Future<void> signUp(SignUpRequestModel request) async {
    await _repo.signUp(request);
    await _repo.signOut();
  }
}

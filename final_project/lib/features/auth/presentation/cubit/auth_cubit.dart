import 'package:final_project/features/auth/data/model/auth_request_model.dart';
import 'package:final_project/features/auth/domain/usecase/auth_usecases.dart';
import 'package:flutter/foundation.dart';

class AuthCubit extends ChangeNotifier {
  AuthCubit(this._useCases);

  final AuthUseCases _useCases;

  Future<void> signIn({required String email, required String password}) {
    return _useCases.signIn(
      SignInRequestModel(email: email, password: password),
    );
  }

  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    await _useCases.signUp(
      SignUpRequestModel(userName: userName, email: email, password: password),
    );
  }
}

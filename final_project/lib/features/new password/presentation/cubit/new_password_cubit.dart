import 'package:final_project/features/new%20password/domain/usecase/new_password_usecases.dart';
import 'package:flutter/foundation.dart';

class NewPasswordCubit extends ChangeNotifier {
  NewPasswordCubit(this._useCases);

  final NewPasswordUseCases _useCases;

  String? validatePassword({
    required String password,
    required String confirmPassword,
  }) {
    return _useCases.validatePassword(
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}

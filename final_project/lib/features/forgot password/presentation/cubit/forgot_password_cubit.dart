import 'package:final_project/features/forgot%20password/domain/usecase/forgot_password_usecases.dart';
import 'package:flutter/foundation.dart';

class ForgotPasswordCubit extends ChangeNotifier {
  ForgotPasswordCubit(this._useCases);

  final ForgotPasswordUseCases _useCases;

  String? validateEmailOrPhone(String value) {
    return _useCases.validateEmailOrPhone(value);
  }
}

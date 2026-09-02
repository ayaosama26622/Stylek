import 'package:final_project/features/forgot%20password/data/model/forgot_password_model.dart';
import 'package:final_project/features/forgot%20password/data/repo/forgot_password_repo.dart';

class ForgotPasswordUseCases {
  ForgotPasswordUseCases(this._repo);

  final ForgotPasswordRepo _repo;

  String? validateEmailOrPhone(String value) {
    return _repo.validateEmailOrPhone(ForgotPasswordModel(emailOrPhone: value));
  }
}

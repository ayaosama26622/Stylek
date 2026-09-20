import 'package:final_project/features/new%20password/data/model/new_password_model.dart';
import 'package:final_project/features/new%20password/data/repo/new_password_repo.dart';

class NewPasswordUseCases {
  NewPasswordUseCases(this._repo);

  final NewPasswordRepo _repo;

  String? validatePassword({
    required String password,
    required String confirmPassword,
  }) {
    return _repo.validatePassword(
      NewPasswordModel(password: password, confirmPassword: confirmPassword),
    );
  }
}

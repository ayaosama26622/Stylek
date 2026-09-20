import 'package:final_project/features/Verification%20code/data/model/verification_code_model.dart';
import 'package:final_project/features/Verification%20code/data/repo/verification_repo.dart';

class VerificationUseCases {
  VerificationUseCases(this._repo);

  final VerificationRepo _repo;

  bool isValidOtp(String value) {
    return _repo.isValidOtp(VerificationCodeModel(code: value));
  }
}

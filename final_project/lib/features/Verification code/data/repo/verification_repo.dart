import 'package:final_project/features/Verification%20code/data/model/verification_code_model.dart';

class VerificationRepo {
  bool isValidOtp(VerificationCodeModel model) {
    return model.code.trim().length >= 4;
  }
}

import 'package:final_project/features/Verification%20code/domain/usecase/verification_usecases.dart';
import 'package:flutter/foundation.dart';

class VerificationCubit extends ChangeNotifier {
  VerificationCubit(this._useCases);

  final VerificationUseCases _useCases;

  bool isValidOtp(String value) {
    return _useCases.isValidOtp(value);
  }
}

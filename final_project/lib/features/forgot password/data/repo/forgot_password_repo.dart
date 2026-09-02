import 'package:final_project/features/forgot%20password/data/model/forgot_password_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class ForgotPasswordRepo {
  String? validateEmailOrPhone(ForgotPasswordModel model) {
    if (model.emailOrPhone.trim().isEmpty) {
      return 'forgot_password.email_or_phone_required'.tr();
    }
    return null;
  }
}

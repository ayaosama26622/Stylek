import 'package:final_project/features/new%20password/data/model/new_password_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class NewPasswordRepo {
  String? validatePassword(NewPasswordModel model) {
    if (model.password.trim().isEmpty) {
      return 'auth.password_required'.tr();
    }
    if (model.password.length < 6) {
      return 'auth.password_too_short'.tr();
    }
    if (model.password != model.confirmPassword) {
      return 'auth.passwords_do_not_match'.tr();
    }
    return null;
  }
}

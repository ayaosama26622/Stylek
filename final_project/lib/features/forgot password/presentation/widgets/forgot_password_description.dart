import 'package:final_project/core/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class ForgotPasswordDescription extends StatelessWidget {
  const ForgotPasswordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'forgot_password.description'.tr(),
      style: TextStyle(
        color: AppColor.mutedVisible(context),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }
}

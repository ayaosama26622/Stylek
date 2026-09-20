import 'package:final_project/core/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class NewPasswordDescription extends StatelessWidget {
  const NewPasswordDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'new_password.description'.tr(),
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColor.mutedVisible(context),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

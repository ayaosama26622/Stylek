import 'package:final_project/core/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpField extends StatefulWidget {
  final TextEditingController controller;

  const OtpField({super.key, required this.controller});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final SmsRetriever smsRetriever;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    smsRetriever = SmsRetrieverImpl(SmartAuth.instance);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColor.onSurface(context),
      ),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.greyColor(context).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
    );

    return Center(
      child: Pinput(
        length: 6,
        controller: widget.controller,
        focusNode: focusNode,
        smsRetriever: smsRetriever,
        defaultPinTheme: defaultPinTheme,

        validator: (value) {
          if (value == null || value.length < 6) {
            return 'verification.enter_full_code'.tr();
          }
          return null;
        },

        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColor.primaryPink, width: 2),
          ),
        ),

        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColor.primaryBlue, width: 2),
          ),
        ),

        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColor.errorColor, width: 2),
          ),
        ),
      ),
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeUserConsentApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithUserConsentApi();
    return res.data?.code;
  }

  @override
  bool get listenForMultipleSms => false;
}

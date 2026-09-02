import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/widgets/app_centered_title.dart';
import 'package:final_project/core/widgets/otp_field.dart';
import 'package:final_project/features/Verification%20code/data/repo/verification_repo.dart';
import 'package:final_project/features/Verification%20code/domain/usecase/verification_usecases.dart';
import 'package:final_project/features/Verification%20code/presentation/cubit/verification_cubit.dart';
import 'package:final_project/features/Verification%20code/presentation/widgets/resend_code_button.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/main_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  late final VerificationCubit _verificationCubit;

  @override
  void initState() {
    super.initState();
    _verificationCubit = VerificationCubit(
      VerificationUseCases(VerificationRepo()),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _verificationCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      AppCenteredTitle('verification.title'.tr()),

                      const SizedBox(height: 35),

                      Center(
                        child: Image.asset(
                          AppImages.verificationCode,
                          height: 210,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.mark_email_read_outlined,
                              size: 110,
                              color: AppColor.greyColor(context),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 35),

                      Text(
                        'verification.title'.tr(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColor.onSurface(context),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        'verification.description'.tr(),
                        style: TextStyle(
                          color: AppColor.mutedVisible(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),

                      Center(
                        child: Text(
                          '+0123456778',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColor.onSurface(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      OtpField(controller: _otpController),

                      const SizedBox(height: 16),

                      ResendCodeButton(onTap: () {}),

                      const SizedBox(height: 40),

                      MainButton(
                        text: 'verification.verify'.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _verificationCubit.isValidOtp(
                                _otpController.text,
                              )) {
                            context.push(Routes.newPassword);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

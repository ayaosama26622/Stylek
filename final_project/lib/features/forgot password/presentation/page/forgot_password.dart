import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/forgot%20password/data/repo/forgot_password_repo.dart';
import 'package:final_project/features/forgot%20password/domain/usecase/forgot_password_usecases.dart';
import 'package:final_project/features/forgot%20password/presentation/cubit/forgot_password_cubit.dart';
import 'package:final_project/features/forgot%20password/presentation/widgets/forgot_password_description.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:go_router/go_router.dart';
import 'package:final_project/core/widgets/custom_text_from_field.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_centered_title.dart';
import 'package:final_project/core/widgets/main_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  late final ForgotPasswordCubit _forgotPasswordCubit;
  String? _emailOrPhoneError;

  @override
  void initState() {
    super.initState();
    _forgotPasswordCubit = ForgotPasswordCubit(
      ForgotPasswordUseCases(ForgotPasswordRepo()),
    );
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _forgotPasswordCubit.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      _emailOrPhoneError = _forgotPasswordCubit.validateEmailOrPhone(
        _emailOrPhoneController.text,
      );
    });
    return _emailOrPhoneError == null;
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
                      AppCenteredTitle('forgot_password.title'.tr()),
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset(
                          AppImages.forgotPassword,
                          height: 210,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.lock_reset,
                              size: 110,
                              color: AppColor.greyColor(context),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        'forgot_password.title'.tr(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColor.onSurface(context),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const ForgotPasswordDescription(),
                      const SizedBox(height: 40),
                      Text(
                        'forgot_password.email_or_phone'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.onSurface(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomGradientBorder(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomTextFormField(
                          controller: _emailOrPhoneController,
                          hintText: 'forgot_password.email_or_phone_hint'.tr(),
                        ),
                      ),
                      if (_emailOrPhoneError != null) ...[
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _emailOrPhoneError!,
                            style: const TextStyle(
                              color: AppColor.errorColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 35),
                      MainButton(
                        text: 'forgot_password.request_code'.tr(),
                        onPressed: () {
                          if (_validateFields()) {
                            context.push(Routes.verification);
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

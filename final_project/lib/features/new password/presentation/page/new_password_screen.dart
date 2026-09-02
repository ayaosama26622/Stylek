import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/widgets/app_centered_title.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/features/new%20password/data/repo/new_password_repo.dart';
import 'package:final_project/features/new%20password/domain/usecase/new_password_usecases.dart';
import 'package:final_project/features/new%20password/presentation/cubit/new_password_cubit.dart';
import 'package:final_project/features/new%20password/presentation/widgets/new_password_description.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/core/widgets/custom_text_from_field.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:go_router/go_router.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final NewPasswordCubit _newPasswordCubit;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _newPasswordCubit = NewPasswordCubit(
      NewPasswordUseCases(NewPasswordRepo()),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 30),
                      AppCenteredTitle('new_password.title'.tr()),
                      const SizedBox(height: 30),

                      Center(
                        child: Image.asset(
                          AppImages.newPassword,
                          height: 160,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Text(
                        'new_password.title'.tr(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColor.onSurface(context),
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const NewPasswordDescription(),

                      const SizedBox(height: 30),

                      Text(
                        'new_password.new_password'.tr(),
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
                          controller: _newPasswordController,
                          hintText: 'new_password.password_hint'.tr(),
                          obscureText: _obscureNewPassword,
                          textAlign: TextAlign.left,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColor.greyColor(context),
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscureNewPassword = !_obscureNewPassword,
                            ),
                            icon: Icon(
                              _obscureNewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColor.greyColor(context),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'new_password.confirm_password'.tr(),
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
                          controller: _confirmPasswordController,
                          hintText: 'new_password.confirm_password_hint'.tr(),
                          obscureText: _obscureConfirmPassword,
                          textAlign: TextAlign.left,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColor.greyColor(context),
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                            ),
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColor.greyColor(context),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      MainButton(
                        text: 'new_password.next'.tr(),
                        onPressed: () {
                          final error = _newPasswordCubit.validatePassword(
                            password: _newPasswordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );
                          if (error != null) {
                            showErrorSnackBar(context, error);
                            return;
                          }
                          context.go(Routes.login);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

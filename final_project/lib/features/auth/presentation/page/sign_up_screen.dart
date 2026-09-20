import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/services/firebase/firebase_error_message.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/features/auth/data/repo/auth_repo.dart';
import 'package:final_project/features/auth/domain/usecase/auth_usecases.dart';
import 'package:final_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:final_project/features/auth/presentation/widgets/auth_hero_header.dart';
import 'package:go_router/go_router.dart';
import 'package:final_project/core/widgets/auth_form_field.dart';
import 'package:final_project/features/auth/presentation/widgets/auth_toggle_capsule.dart';
import 'package:final_project/features/auth/presentation/widgets/social_card.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/main_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final AuthCubit _authCubit;

  String? _userNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(AuthUseCases(AuthRepo()));
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authCubit.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      if (_userNameController.text.isEmpty) {
        _userNameError = 'auth.username_required'.tr();
      } else {
        _userNameError = null;
      }

      if (_emailController.text.isEmpty) {
        _emailError = 'auth.email_required'.tr();
      } else if (!_emailController.text.contains('@')) {
        _emailError = 'auth.email_invalid'.tr();
      } else {
        _emailError = null;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'auth.password_required'.tr();
      } else {
        _passwordError = null;
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'auth.confirm_password_required'.tr();
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'auth.passwords_do_not_match'.tr();
      } else {
        _confirmPasswordError = null;
      }
    });

    return _userNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
  }

  Future<void> _signUp() async {
    if (!_validateFields() || _isLoading) return;
    setState(() => _isLoading = true);
    try {
      await _authCubit.signUp(
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        showSuccessSnackBar(context, 'auth.account_created'.tr());
        context.go(Routes.login);
      }
    } catch (error) {
      if (!mounted) return;
      showErrorSnackBar(context, firebaseErrorMessage(error));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 24),
                                AuthHeroHeader(
                                  title: 'auth.sign_up'.tr(),
                                  imagePath: AppImages.signup,
                                  fallbackIcon: Icons.image,
                                  imageHeight: 140,
                                  titleFontSize: 26,
                                  fallbackIconSize: 80,
                                ),
                                const SizedBox(height: 20),
                                const AuthToggleCapsule(),
                                const SizedBox(height: 40),
                                AuthFormField(
                                  label: 'auth.user_name'.tr(),
                                  hintText: 'auth.user_name_hint'.tr(),
                                  controller: _userNameController,
                                  errorText: _userNameError,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColor.greyColor(context),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AuthFormField(
                                  label: 'auth.email'.tr(),
                                  hintText: 'auth.email_hint'.tr(),
                                  controller: _emailController,
                                  errorText: _emailError,
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: AppColor.greyColor(context),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AuthFormField(
                                  label: 'auth.password'.tr(),
                                  hintText: 'auth.password_hint'.tr(),
                                  controller: _passwordController,
                                  errorText: _passwordError,
                                  obscureText: _obscurePassword,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColor.greyColor(context),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(
                                      () => _obscurePassword =
                                          !_obscurePassword,
                                    ),
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColor.greyColor(context),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AuthFormField(
                                  label: 'auth.confirm_password'.tr(),
                                  hintText: 'auth.confirm_password_hint'.tr(),
                                  controller: _confirmPasswordController,
                                  errorText: _confirmPasswordError,
                                  obscureText: _obscureConfirmPassword,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColor.greyColor(context),
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
                              ],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MainButton(
                                  text: _isLoading
                                      ? 'auth.please_wait'.tr()
                                      : 'auth.sign_up'.tr(),
                                  onPressed: _signUp,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: AppColor.greyColor(context),
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0,
                                      ),
                                      child: Text(
                                        'auth.or_continue_with'.tr(),
                                        style: TextStyle(
                                          color: AppColor.greyColor(context).withValues(
                                            alpha: 0.8,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: AppColor.greyColor(context),
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SocialCard(
                                        icon: const Text(
                                          'G',
                                          style: TextStyle(
                                            color: AppColor.errorColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        label: 'auth.google_email'.tr(),
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: SocialCard(
                                        icon: Icon(
                                          Icons.apple,
                                          color: AppColor.onSurface(context),
                                          size: 20,
                                        ),
                                        label: 'auth.apple_email'.tr(),
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'auth.have_account'.tr(),
                                      style: TextStyle(
                                        color: AppColor.onSurface(context),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.go(Routes.login);
                                      },
                                      child: Text(
                                        'auth.sign_in_lower'.tr(),
                                        style: TextStyle(
                                          color: AppColor.errorColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

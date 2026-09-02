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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthCubit _authCubit;

  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(AuthUseCases(AuthRepo()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authCubit.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = 'auth.email_required'.tr();
      } else if (!_emailController.text.contains('@')) {
        _emailError = 'auth.email_invalid'.tr();
      } else {
        _emailError = null;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'auth.password_required'.tr();
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'auth.password_too_short'.tr();
      } else {
        _passwordError = null;
      }
    });

    return _emailError == null && _passwordError == null;
  }

  Future<void> _signIn() async {
    if (!_validateFields() || _isLoading) return;
    setState(() => _isLoading = true);
    try {
      await _authCubit.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) context.go(Routes.home);
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    AuthHeroHeader(
                      title: 'auth.sign_in'.tr(),
                      imagePath: AppImages.signin,
                      fallbackIcon: Icons.image,
                      imageHeight: 180,
                      fallbackIconSize: 100,
                    ),
                    const SizedBox(height: 25),
                    const AuthToggleCapsule(),
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 12),
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
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColor.greyColor(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.go(Routes.forgotPassword);
                        },
                        child: Text(
                          'auth.forgot_password'.tr(),
                          style: TextStyle(
                            color: AppColor.onSurface(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    MainButton(
                      text: _isLoading ? 'auth.please_wait'.tr() : 'auth.sign_in'.tr(),
                      onPressed: _signIn,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColor.greyColor(context),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'auth.or_continue_with'.tr(),
                            style: TextStyle(
                              color: AppColor.greyColor(context),
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SocialCard(
                            icon: const Text(
                              'G',
                              style: TextStyle(
                                color: AppColor.errorColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            label: 'auth.google_email'.tr(),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialCard(
                            icon: Icon(
                              Icons.apple,
                              color: AppColor.onSurface(context),
                              size: 22,
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
                          'auth.dont_have_account'.tr(),
                          style: TextStyle(
                            color: AppColor.onSurface(context),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go(Routes.signup);
                          },
                          child: Text(
                            'auth.sign_up_lower'.tr(),
                            style: TextStyle(
                              color: AppColor.errorColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

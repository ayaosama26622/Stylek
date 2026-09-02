// Edit profile screen: update display name, email, and password.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/services/firebase/firebase_error_message.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/core/widgets/custom_text_from_field.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:final_project/features/profile/data/model/profile_user_model.dart';
import 'package:final_project/features/profile/data/repo/profile_repo.dart';
import 'package:final_project/features/profile/domain/usecase/profile_usecases.dart';
import 'package:final_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final ProfileCubit _profileCubit;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _currentPasswordController = TextEditingController();

  bool _hasPrefilled = false;
  bool _isSaving = false;
  bool _obscureNewPassword = true;
  bool _obscureCurrentPassword = true;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(ProfileUseCases(ProfileRepo()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    _profileCubit.dispose();
    super.dispose();
  }

  void _prefillIfNeeded(ProfileUserModel profile) {
    if (_hasPrefilled) return;
    _hasPrefilled = true;
    _nameController.text = profile.name;
    _emailController.text = profile.email;
  }

  Future<void> _save() async {
    if (_isSaving) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text;
    final currentPassword = _currentPasswordController.text;

    final emailChanged = email.isNotEmpty && email != _profileCubit.email;
    final wantsPasswordChange = newPassword.isNotEmpty;

    if ((emailChanged || wantsPasswordChange) && currentPassword.isEmpty) {
      showErrorSnackBar(
        context,
        'edit_profile.current_password_required'.tr(),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      if (name.isNotEmpty) {
        await _profileCubit.updateName(name);
      }
      if (emailChanged) {
        await _profileCubit.updateEmail(
          newEmail: email,
          currentPassword: currentPassword,
        );
      }
      if (wantsPasswordChange) {
        await _profileCubit.updatePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
      }
      if (!mounted) return;
      showSuccessSnackBar(context, 'edit_profile.updated_successfully'.tr());
      if (emailChanged) {
        showSuccessSnackBar(
          context,
          'edit_profile.verification_sent'.tr(),
        );
      }
      context.pop();
    } catch (error) {
      if (mounted) showErrorSnackBar(context, firebaseErrorMessage(error));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                AppHeaderBar(
                  title: 'edit_profile.title'.tr(),
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: _profileCubit.watchCurrentUser(),
                    builder: (context, snapshot) {
                      final data = snapshot.data?.data();
                      final fallbackName = _profileCubit.displayName.isEmpty
                          ? 'common.default_user'.tr()
                          : _profileCubit.displayName;
                      final profile = ProfileUserModel.fromMap(
                        data,
                        fallbackName: fallbackName,
                        fallbackEmail: _profileCubit.email,
                      );
                      _prefillIfNeeded(profile);

                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('edit_profile.name'.tr()),
                            const SizedBox(height: 8),
                            CustomGradientBorder(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomTextFormField(
                                controller: _nameController,
                                hintText: 'edit_profile.name_hint'.tr(),
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: AppColor.greyColor(context),
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            _fieldLabel('edit_profile.email'.tr()),
                            const SizedBox(height: 8),
                            CustomGradientBorder(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomTextFormField(
                                controller: _emailController,
                                hintText: 'edit_profile.email_hint'.tr(),
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icon(
                                  Icons.mail_outline_rounded,
                                  color: AppColor.greyColor(context),
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            _fieldLabel('edit_profile.new_password'.tr()),
                            const SizedBox(height: 8),
                            CustomGradientBorder(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomTextFormField(
                                controller: _newPasswordController,
                                hintText: 'edit_profile.new_password_hint'.tr(),
                                obscureText: _obscureNewPassword,
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColor.greyColor(context),
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNewPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColor.greyColor(context),
                                    size: 20,
                                  ),
                                  onPressed: () => setState(() {
                                    _obscureNewPassword =
                                        !_obscureNewPassword;
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            _fieldLabel('edit_profile.current_password'.tr()),
                            const SizedBox(height: 4),
                            Text(
                              'edit_profile.current_password_note'.tr(),
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColor.greyColor(context),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomGradientBorder(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomTextFormField(
                                controller: _currentPasswordController,
                                hintText: 'edit_profile.current_password'.tr(),
                                obscureText: _obscureCurrentPassword,
                                prefixIcon: Icon(
                                  Icons.lock_person_outlined,
                                  color: AppColor.greyColor(context),
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureCurrentPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColor.greyColor(context),
                                    size: 20,
                                  ),
                                  onPressed: () => setState(() {
                                    _obscureCurrentPassword =
                                        !_obscureCurrentPassword;
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),

                            MainButton(
                              text: _isSaving ? 'edit_profile.saving'.tr() : 'edit_profile.save_changes'.tr(),
                              onPressed: _isSaving ? () {} : _save,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColor.onSurface(context),
      ),
    );
  }
}

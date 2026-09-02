import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/cubit/theme_cubit.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/services/firebase/firebase_error_message.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/features/profile/data/model/profile_user_model.dart';
import 'package:final_project/features/profile/data/repo/profile_repo.dart';
import 'package:final_project/features/profile/domain/usecase/profile_usecases.dart';
import 'package:final_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

part '../widgets/profile_identity_widgets.dart';
part '../widgets/profile_menu_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isUploading = false;
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit(ProfileUseCases(ProfileRepo()));
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    if (_isUploading) return;
    setState(() => _isUploading = true);
    try {
      await _profileCubit.pickAndUploadImage(source);
      if (mounted) showSuccessSnackBar(context, 'profile.image_updated'.tr());
    } on PlatformException catch (error) {
      if (!mounted) return;
      if (error.code == 'camera_access_denied') {
        showErrorSnackBar(
          context,
          'profile.camera_denied'.tr(),
        );
      } else if (error.code == 'photo_access_denied') {
        showErrorSnackBar(
          context,
          'profile.photo_denied'.tr(),
        );
      } else {
        showErrorSnackBar(context, error.message ?? 'profile.something_wrong'.tr());
      }
    } catch (error) {
      if (mounted) showErrorSnackBar(context, firebaseErrorMessage(error));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  void dispose() {
    _profileCubit.dispose();
    super.dispose();
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
                AppHeaderBar(title: 'profile.title'.tr(), onBack: widget.onBack),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                    children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _profileCubit.watchCurrentUser(),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.data();
                    final fallbackName = _profileCubit.displayName.isEmpty
                        ? 'profile.default_user'.tr()
                        : _profileCubit.displayName;
                    final profile = ProfileUserModel.fromMap(
                      data,
                      fallbackName: fallbackName,
                      fallbackEmail: _profileCubit.email,
                    );
                    return _ProfileIdentity(
                      name: profile.name,
                      email: profile.email,
                      avatar: profile.avatar,
                      isUploading: _isUploading,
                      onCameraTap: () =>
                          _pickAndUploadImage(ImageSource.camera),
                      onImageTap: () =>
                          _pickAndUploadImage(ImageSource.gallery),
                    );
                  },
                ),
                const SizedBox(height: 24),
                _ProfileSection(
                  title: 'profile.personal_information'.tr(),
                  items: [
                    _ProfileMenuItem(
                      icon: Icons.mail_outline_rounded,
                      label: 'profile.email'.tr(),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.phone_outlined,
                      label: 'profile.mobile_number'.tr(),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.lock_outline_rounded,
                      label: 'profile.password_and_security'.tr(),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.public_outlined,
                      label: 'profile.country'.tr(),
                      showDivider: false,
                    ),
                  ],
                ),
                SizedBox(height: 22),
                _ProfileSection(
                  title: 'profile.orders'.tr(),
                  items: [
                    _ProfileMenuItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'profile.my_orders'.tr(),
                      onTap: () => context.push(Routes.myOrders),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.local_shipping_outlined,
                      label: 'profile.track_order'.tr(),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.history_rounded,
                      label: 'profile.order_history'.tr(),
                      showDivider: false,
                    ),
                  ],
                ),
                SizedBox(height: 22),
                _ProfileSection(
                  title: 'profile.controls'.tr(),
                  items: [
                    ListenableBuilder(
                      listenable: ThemeCubit.instance,
                      builder: (context, _) => _ProfileSwitchItem(
                        icon: Icons.dark_mode_outlined,
                        label: 'profile.dark_mode'.tr(),
                        value: ThemeCubit.instance.isDarkMode,
                        onChanged: (value) {
                          ThemeCubit.instance.setDarkMode(value);
                        },
                      ),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.language_rounded,
                      label:
                          '${'profile.language'.tr()} '
                          '(${context.locale.languageCode.toUpperCase()})',
                      onTap: () {
                        final next = context.locale.languageCode == 'ar'
                            ? const Locale('en')
                            : const Locale('ar');
                        context.setLocale(next);
                      },
                    ),
                    _ProfileMenuItem(
                      icon: Icons.sync_alt_rounded,
                      label: 'profile.switch_account'.tr(),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      label: 'profile.log_out'.tr(),
                      showDivider: false,
                      onTap: () async {
                        await _profileCubit.signOut();
                        if (context.mounted) context.go(Routes.login);
                      },
                    ),
                  ],
                ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

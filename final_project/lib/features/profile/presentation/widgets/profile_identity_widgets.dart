part of '../page/profile_screen.dart';

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity({
    required this.name,
    required this.email,
    required this.avatar,
    required this.isUploading,
    required this.onCameraTap,
    required this.onImageTap,
  });

  final String name;
  final String email;
  final String avatar;
  final bool isUploading;
  final VoidCallback onCameraTap;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            color: AppColor.surface(context),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.greyColor(context).withValues(alpha: 0.3),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: isUploading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
              : avatar.isEmpty
              ? Icon(
                  Icons.person_outline_rounded,
                  color: AppColor.onSurface(context),
                  size: 42,
                )
              : Image.network(
                  avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person_outline_rounded,
                    color: AppColor.onSurface(context),
                    size: 42,
                  ),
                ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColor.onSurface(context),
          ),
        ),
        if (email.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColor.greyColor(context),
            ),
          ),
        ],
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileQuickAction(
              icon: Icons.edit_outlined,
              label: 'profile.edit'.tr(),
              isActive: true,
              onTap: () => context.push(Routes.editProfile),
            ),
            const SizedBox(width: 10),
            _ProfileQuickAction(
              icon: Icons.camera_alt_outlined,
              label: 'profile.camera'.tr(),
              onTap: onCameraTap,
            ),
            const SizedBox(width: 10),
            _ProfileQuickAction(
              icon: Icons.image_outlined,
              label: 'profile.image'.tr(),
              onTap: onImageTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileQuickAction extends StatelessWidget {
  const _ProfileQuickAction({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isActive
          ? Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: AppColor.primaryPink,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColor.darkColor(context).withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColor.darkColor(context),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(icon, size: 16, color: AppColor.darkColor(context)),
                ],
              ),
            )
          : SizedBox(
              width: 44,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20, color: AppColor.greyColor(context)),
                  const SizedBox(height: 1),
                  Text(
                    label,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColor.greyColor(context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

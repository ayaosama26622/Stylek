import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarImage,
  });

  final String userName;
  final String avatarImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColor.surface(context),
          child: ClipOval(
            child: avatarImage.isEmpty
                ? Icon(Icons.person_outline, color: AppColor.onSurface(context))
                : Image.network(
                    avatarImage,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_outline,
                      color: AppColor.onSurface(context),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello $userName',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColor.onSurface(context),
                ),
              ),
              Text(
                'home.welcome_back'.tr(),
                style: TextStyle(fontSize: 14, color: AppColor.mutedVisible(context)),
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/images/logo2.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          color: AppColor.onSurface(context),
          colorBlendMode: BlendMode.srcIn,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.checkroom_rounded, color: AppColor.onSurface(context)),
        ),
      ],
    );
  }
}

import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:go_router/go_router.dart';

class AuthToggleCapsule extends StatelessWidget {
  const AuthToggleCapsule({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();
    final bool isSignIn = currentRoute == Routes.login;

    return CustomGradientBorder(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!isSignIn) {
                    context.go(Routes.login);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: isSignIn
                        ? const LinearGradient(colors: AppColor.gradientColors)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'auth.sign_in'.tr(),
                    style: TextStyle(
                      color: isSignIn
                          ? AppColor.darkColor(context)
                          : AppColor.onSurface(context),

                      fontWeight: isSignIn ? FontWeight.w800 : FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isSignIn) {
                    context.go(Routes.signup);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: !isSignIn
                        ? const LinearGradient(colors: AppColor.gradientColors)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'auth.sign_up'.tr(),
                    style: TextStyle(
                      color: !isSignIn
                          ? AppColor.darkColor(context)
                          : AppColor.onSurface(context),
                      fontWeight: !isSignIn ? FontWeight.w800 : FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

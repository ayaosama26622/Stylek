import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/intro/data/repo/intro_repo.dart';
import 'package:final_project/features/intro/domain/usecase/intro_usecases.dart';
import 'package:final_project/features/intro/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = SplashCubit(IntroUseCases(IntroRepo()));
    _navigate();
  }

  @override
  void dispose() {
    _splashCubit.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    context.go(_splashCubit.nextNavigation().route);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColor.isDark(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : null,
          gradient: isDark
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColor.gradientColors,
                ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            width: 200,
            color: isDark ? Colors.white : null,
            colorBlendMode: isDark ? BlendMode.srcIn : null,
          ),
        ),
      ),
    );
  }
}

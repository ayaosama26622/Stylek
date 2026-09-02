import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/features/intro/data/repo/intro_repo.dart';
import 'package:final_project/features/intro/domain/usecase/intro_usecases.dart';
import 'package:final_project/features/intro/presentation/cubit/onboarding_cubit.dart';
import 'package:final_project/features/intro/presentation/widgets/onboarding_one.dart';
import 'package:final_project/features/intro/presentation/widgets/onboarding_three.dart';
import 'package:final_project/features/intro/presentation/widgets/onboarding_two.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  late final OnboardingCubit _onboardingCubit;

  @override
  void initState() {
    super.initState();
    _onboardingCubit = OnboardingCubit(IntroUseCases(IntroRepo()));
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Future<void> _completeOnboarding() async {
    await _onboardingCubit.completeOnboarding();
    if (mounted) context.go(Routes.login);
  }

  @override
  void dispose() {
    _controller.dispose();
    _onboardingCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        OnboardingOne(onNext: _nextPage, onSkip: _completeOnboarding),
        OnboardingTwo(onNext: _nextPage, onSkip: _completeOnboarding),
        OnboardingThree(
          onReady: _completeOnboarding,
          onSkip: _completeOnboarding,
        ),
      ],
    );
  }
}

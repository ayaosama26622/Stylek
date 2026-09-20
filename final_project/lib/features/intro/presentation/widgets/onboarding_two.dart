import 'dart:math' as math;

import 'package:final_project/core/constants/image_app.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingTwo({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColor.isDark(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFFBE9EE),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 65,
                child: Image.asset(
                  AppImages.header2,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Expanded(flex: 35, child: SizedBox()),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 40,
                left: 32,
                right: 32,
                bottom: 40,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColor.surface(context) : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'onboarding.title_two'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'onboarding.subtitle_two'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? AppColor.greyColor(context)
                          : const Color(0xFF8F8F8F),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(isActive: false, isDark: isDark),
                      const SizedBox(width: 6),
                      _buildDot(isActive: true, isDark: isDark),
                      const SizedBox(width: 6),
                      _buildDot(isActive: false, isDark: isDark),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: onNext,
                        child: CustomPaint(
                          painter: StepTwoReversePainter(isDark: isDark),
                          child: Container(
                            width: 86,
                            height: 86,
                            alignment: Alignment.center,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white : Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: isDark ? Colors.black : Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: onSkip,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'onboarding.skip'.tr(),
                                style: TextStyle(
                                  color: AppColor.onSurface(context),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive, required bool isDark}) {
    return Container(
      width: isActive ? 18 : 14,
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? (isDark ? Colors.white : Colors.black)
            : (isDark ? const Color(0xFF4A4A4A) : const Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class StepTwoReversePainter extends CustomPainter {
  StepTwoReversePainter({this.isDark = false});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 1.5;
    final paint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      -1.33 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant StepTwoReversePainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}

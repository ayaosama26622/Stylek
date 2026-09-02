part of '../page/checkout_screen.dart';

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 124,
        color: const Color(0xFFE6ECE8),
        child: CustomPaint(
          painter: _MapPainter(),
          child: Center(
            child: Icon(Icons.location_pin, size: 54, color: AppColor.darkColor(context)),
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  const _MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 2;
    final riverPaint = Paint()
      ..color = const Color(0xFF58C7EF)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    for (var i = -2; i < 8; i++) {
      final y = i * 26.0;
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 70), roadPaint);
      canvas.drawLine(
        Offset(i * 38.0, 0),
        Offset(i * 38.0 + 95, size.height),
        roadPaint,
      );
    }

    final path = Path()
      ..moveTo(size.width * 0.62, 0)
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.4,
        size.width * 0.68,
        size.height,
      );
    canvas.drawPath(path, riverPaint);

    final pinPaint = Paint()..color = Colors.red;
    for (final point in [
      Offset(size.width * 0.18, size.height * 0.32),
      Offset(size.width * 0.78, size.height * 0.55),
      Offset(size.width * 0.31, size.height * 0.48),
      Offset(size.width * 0.52, size.height * 0.66),
    ]) {
      canvas.drawCircle(point, 3, pinPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

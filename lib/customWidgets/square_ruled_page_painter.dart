import 'package:flutter/material.dart';

class SquareRuledPagePainter extends CustomPainter {
  final int lineSpacingY;
  final int lineSpacingX;
  final Color lineColor;

  SquareRuledPagePainter(
      {this.lineColor = Colors.grey,
      this.lineSpacingY = 30,
      this.lineSpacingX = 30});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    //draw horizontal lines
    for (double y = 0; y < size.height; y += lineSpacingY) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    //draw vertical lines
    for (double x = 0; x < size.width; x += lineSpacingX) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SquareRuledPage extends StatelessWidget {
  final Widget child;
  SquareRuledPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SquareRuledPagePainter(),
      child: child,
    );
  }
}

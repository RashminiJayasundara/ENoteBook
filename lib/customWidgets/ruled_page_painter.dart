import 'package:flutter/material.dart';

class RuledPagePainter extends CustomPainter {
  final int lineSpacing;
  final Color lineColor;

  RuledPagePainter({this.lineColor = Colors.grey, this.lineSpacing = 30});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    //draw horizontal lines
    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RuledPage extends StatelessWidget {
  final Widget child;
  RuledPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RuledPagePainter(),
      child: child,
    );
  }
}

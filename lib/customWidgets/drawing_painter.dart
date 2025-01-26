import 'package:e_note_book/models/drawing_modal.dart';
import 'package:e_note_book/models/point_data_modal.dart';
import 'package:flutter/material.dart';

import '../services/drawing_service.dart';

class DrawingPainter extends CustomPainter {
  List<DrawingPointData?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        final paint = Paint()
          ..color = points[i]!.color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = points[i]!.thickness;
        canvas.drawLine(Offset(points[i]!.point!.dx, points[i]!.point!.dy)!,
            Offset(points[i + 1]!.point!.dx, points[i + 1]!.point!.dy)!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingArea extends StatefulWidget {
  final Color colour;
  final double thikness;
  final int drawingId;

  DrawingArea(
      {required this.colour, required this.thikness, required this.drawingId});
  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  List<DrawingPointData?> points = [];

  @override
  void initState() {
    super.initState();
    _loadPreviousDrawing();
  }

  Future<void> _loadPreviousDrawing() async {
    List<DrawingPointData?> loadedPoints = await loadDrawing(widget.drawingId);
    setState(() {
      points = loadedPoints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(DrawingPointData(
              point: PointData(
                  dx: details.localPosition.dx, dy: details.localPosition.dy),
              color: widget.colour,
              thickness: widget.thikness));
        });
      },
      onPanEnd: (details) async {
        points.add(null);
        await saveDrawing(
            points, widget.drawingId); // Auto-save after each stroke
      },
      child: CustomPaint(
        painter: DrawingPainter(points),
        size: Size.infinite,
      ),
    );
  }
}

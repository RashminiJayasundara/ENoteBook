import 'package:e_note_book/models/point_data_modal.dart';
import 'package:flutter/material.dart';

class DrawingPointData {
  final PointData point;
  final Color color;
  final double thickness;

  DrawingPointData(
      {required this.point, required this.color, required this.thickness});

  Map<String, dynamic> toJson() => {
        'point': point.toJson(),
        'color': color.value,
        'thickness': thickness,
      };

  factory DrawingPointData.fromJson(Map<String, dynamic> json) {
    return DrawingPointData(
      point: PointData.fromJson(json['point']),
      color: Color(json['color']),
      thickness: json['thickness'],
    );
  }
}

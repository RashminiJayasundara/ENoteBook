import 'dart:convert';
import 'dart:io';
import 'package:e_note_book/database/database_helper.dart';
import 'package:e_note_book/models/drawing_modal.dart';
import 'package:e_note_book/models/point_data_modal.dart';
import 'package:flutter/material.dart';

final dbHelper = DatabaseHelper();

Future<void> saveDrawing(List<DrawingPointData?>? points, int drawingId) async {
  if (points == null) {
    print('Error: points list is null');
    return;
  }

  for (var element in points) {
    if (element == null) {
      print('Error: a drawing point is null');
      continue;
    }

    Map<String, dynamic> json = element.toJson();
    Map<String, dynamic> record = {
      'pointX': json['point']['dx'],
      'pointY': json['point']['dy'],
      'color': json['color'],
      'thickness': json['thickness'],
      'drawingId': drawingId,
    };

    await dbHelper.insertDrawingPoints(record);
  }
}

Future<List<DrawingPointData?>> loadDrawing(int drawingId) async {
  List<DrawingPointData?> pointData = [];
  List<Map<String, dynamic>> points =
      await dbHelper.getDrawingPointsByDrawingId(drawingId);
  points!.forEach((element) {
    pointData.add(DrawingPointData(
        point: PointData(dx: element['pointX'], dy: element['pointY']),
        color: Color(element['color']),
        thickness: element['thickness']));
  });
  return pointData;
}

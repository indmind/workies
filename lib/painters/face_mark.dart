import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class FaceMarkPainter extends CustomPainter {
  final ui.Image _image;
  final List<Face> _faces;

  FaceMarkPainter(this._image, this._faces);

  @override
  void paint(Canvas canvas, Size size) {
    Map<String, Paint> paints = {
      "dim": Paint()
        ..color = Colors.grey.withOpacity(0.5)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
      "default": Paint()
        ..color = Colors.green
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
      "eye": Paint()
        ..color = Colors.blue
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
      "nose": Paint()
        ..color = Colors.yellow
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
      "lip": Paint()
        ..color = Colors.red
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    };
    // canvas.translate(-150, -400);

    canvas.drawImage(_image, Offset.zero, Paint());
    _faces.forEach((face) {
      canvas.drawRect(face.boundingBox, paints["dim"]);

      _drawContours(face, canvas, paints);
      _drawLabels(face, canvas, paints);
    });
  }

  void _drawContours(Face f, ui.Canvas canvas, paints) {
    final upperLip = f.getContour(FaceContourType.upperLipTop).positionsList;
    final upperLipBottom =
        f.getContour(FaceContourType.upperLipBottom).positionsList;
    final leftEye = f.getContour(FaceContourType.leftEye).positionsList;
    final rightEye = f.getContour(FaceContourType.rightEye).positionsList;
    final noseBridge = f.getContour(FaceContourType.noseBridge).positionsList;
    final noseBottom = f.getContour(FaceContourType.noseBottom).positionsList;
    final face = f.getContour(FaceContourType.face).positionsList;

    canvas.drawPath(_getPathFromPos(upperLip), paints["lip"]);
    canvas.drawPath(_getPathFromPos(upperLipBottom), paints["lip"]);
    canvas.drawPath(_getPathFromPos(leftEye), paints["eye"]);
    canvas.drawPath(_getPathFromPos(rightEye), paints["eye"]);
    canvas.drawPath(_getPathFromPos(noseBridge), paints["nose"]);
    canvas.drawPath(_getPathFromPos(noseBottom), paints["nose"]);
    canvas.drawPath(_getPathFromPos(face), paints["default"]);
  }

  void _drawLabels(Face face, ui.Canvas canvas, paints) {
    Offset mouth = face.getLandmark(FaceLandmarkType.bottomMouth).position;
    Offset leftEye =
        face.getLandmark(FaceLandmarkType.leftEye).position + Offset(0, 20);
    Offset rightEye =
        face.getLandmark(FaceLandmarkType.rightEye).position + Offset(0, 20);

    _drawText(canvas, "Mulut", mouth);
    _drawText(canvas, "Mata Kanan", leftEye);
    _drawText(canvas, "Mata Kiri", rightEye);
  }

  _getPathFromPos(List<Offset> positions) {
    final path = Path();

    path.moveTo(positions[0].dx, positions[0].dy);

    positions.skip(1).forEach((pos) => path.lineTo(pos.dx, pos.dy));

    return path;
  }

  void _drawText(Canvas canvas, String text, Offset position) {
    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 18.0),
      text: text,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, position);
  }

  @override
  bool shouldRepaint(FaceMarkPainter oldDelegate) {
    return oldDelegate._faces != _faces;
  }
}

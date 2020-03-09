import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workies/painters/face_mark.dart';

class FaceDetectScreen extends StatefulWidget {
  @override
  _FaceDetectScreenState createState() => _FaceDetectScreenState();
}

class _FaceDetectScreenState extends State<FaceDetectScreen> {
  ui.Image _image;
  List<Face> _faces = List<Face>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Center(
            child: FittedBox(
              // fit: BoxFit.cover,
              child: SizedBox(
                width: _image?.width?.toDouble(),
                height: _image?.height?.toDouble(),
                child: CustomPaint(
                  painter: FaceMarkPainter(_image, _faces),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: FlatButton(
              onPressed: _getImageAndDetectFaces,
              child: Text("Pick Image"),
            ),
          ),
        ],
      ),
    );
  }

  List<Positioned> _buildFacesMarks(List<Face> faces) {
    if (faces == null) return [];

    return faces
        .map(
          (f) => Positioned.fromRect(
            rect: Rect.fromLTRB(
              f.boundingBox.left - 100,
              f.boundingBox.top - 350,
              f.boundingBox.right - 200,
              f.boundingBox.bottom - 400,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red.withOpacity(0.8),
                  width: 10,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        )
        .toList();
  }

  void _getImageAndDetectFaces() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile == null) return;

    final image = FirebaseVisionImage.fromFile(imageFile);

    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
        enableContours: true,
        enableLandmarks: true,
      ),
    );

    final faces = await faceDetector.processImage(image);

    print("detected ${faces.length} faces");

    final imageByte = await imageFile.readAsBytes();

    if (mounted) {
      await decodeImageFromList(imageByte).then(
        (image) => setState(() {
          _image = image;
          _faces = faces;
        }),
      );
    }
  }
}

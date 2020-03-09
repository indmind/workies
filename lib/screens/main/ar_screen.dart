import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArScreen extends StatefulWidget {
  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _onPlateTapHandler;
    arCoreController.onPlaneDetected = _onPlaneDetected;

    _addSphere(arCoreController, Colors.grey, vector.Vector3(0, 0, -1));
  }

  void onTapHandler(String name) {
    print("onNodeTap on $name");
  }

  void _onPlateTapHandler(List<ArCoreHitTestResult> hits) {
    vector.Vector3 position =
        hits.first.pose.translation + vector.Vector3(0.0, 1.0, 0.0);

    print("hit at $position");

    _addSphere(arCoreController, Colors.blue, position);
  }

  void _onPlaneDetected(ArCorePlane plane) {
    _addSphere(
      arCoreController,
      Colors.green,
      plane.centerPose.translation + vector.Vector3(0.0, 1.0, 0.0),
    );
  }

  _addSphere(
      ArCoreController controller, Color color, vector.Vector3 position) {
    final ArCoreMaterial material = ArCoreMaterial(color: color);
    final ArCoreSphere sphere =
        ArCoreSphere(materials: [material], radius: 0.03);
    final ArCoreNode node = ArCoreNode(
      shape: sphere,
      position: position,
    );

    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class ImageDiffuseScreen extends StatefulWidget {
  const ImageDiffuseScreen({Key? key}) : super(key: key);

  @override
  State<ImageDiffuseScreen> createState() => _ImageDiffuseScreenState();
}

class _ImageDiffuseScreenState extends State<ImageDiffuseScreen> {
  late ARKitController arkitController;
  ARKitNode? sphereNode;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        onARKitViewCreated: onARKitViewCreated,
        enablePinchRecognizer: true,
        enablePanRecognizer: true,
        enableRotationRecognizer: true,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);

    final node = ARKitNode(
      geometry: ARKitSphere(
        radius: 0.5,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.image(
              'assets/earth.png',
            ),
          )
        ],
      ),
      position: vector.Vector3(0, 0, -0.5),
    );
    arkitController.add(node);

    sphereNode = node;
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    final pinchNode = pinch.firstWhere(
      (e) => e.nodeName == sphereNode?.name,
    );

    final scale = vector.Vector3.all(pinchNode.scale);
    sphereNode?.scale = scale;
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    print(pan.first.translation);
    final panNode = pan.firstWhere((e) => e.nodeName == sphereNode?.name);

    // final old = sphereNode?.eulerAngles;
    final newAngleZ = panNode.translation.x * math.pi / 180;
    final newAnglY = panNode.translation.x * math.pi / 180;
    final newAnglX = panNode.translation.x * math.pi / 180;
    sphereNode?.eulerAngles = vector.Vector3(newAnglX, newAnglY, newAngleZ);
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotate) {
    print(rotate);
    final rotationNode = rotate.firstWhere(
      (e) => e.nodeName == sphereNode?.name,
    );
    // if (rotationNode != null) {
    final rotation = sphereNode?.eulerAngles ??
        vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
    sphereNode?.eulerAngles = rotation;
    // }
  }
}

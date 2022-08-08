import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomDragon extends StatefulWidget {
  const CustomDragon({Key? key}) : super(key: key);

  @override
  State<CustomDragon> createState() => _CustomDragonState();
}

class _CustomDragonState extends State<CustomDragon> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Dragon on Plane'),
        ),
        body: Container(
          child: ARKitSceneView(
            planeDetection: ARPlaneDetection.horizontalAndVertical,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.tracking);
    arkitController.onAddNodeForAnchor = _handleAddAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addCustomObject(arkitController, anchor);
    }
  }

  void _addCustomObject(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/dragon.dae',
      position: vector.Vector3(0, -0.3, 0),
      scale: vector.Vector3.all(0.01),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }
}

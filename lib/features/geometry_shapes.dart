import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class GeometryShapesScreen extends StatefulWidget {
  const GeometryShapesScreen({Key? key}) : super(key: key);

  @override
  State<GeometryShapesScreen> createState() => _GeometryShapesScreenState();
}

class _GeometryShapesScreenState extends State<GeometryShapesScreen> {
  late ARKitController arkitController;

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
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
      geometry: ARKitSphere(
        radius: 0.01,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(
              Colors.red,
            ),
          )
        ],
      ),
      position: vector.Vector3.zero(),
    );

    arkitController.add(node);
  }
}

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({Key? key}) : super(key: key);

  @override
  State<FaceDetectionScreen> createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late ARKitController arkitController;
  String faceStatus = '';

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(faceStatus),
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            configuration: ARKitConfiguration.faceTracking,
            onARKitViewCreated: onARKitViewCreated,
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Text(
          //     faceStatus,
          //     style: Theme.of(context).textTheme.headline6?.copyWith(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // )
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) async {
    this.arkitController = controller;
    this.arkitController.onUpdateNodeForAnchor = onUpdateNodeForAnchor;
  }

  void onUpdateNodeForAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitFaceAnchor) {
      ARKitFaceAnchor faceAnchor = anchor;
      // final smile = faceAnchor.blendShapes['jawOpen']!;
      final smile = faceAnchor.blendShapes['jawOpen']!;
      // final smile = faceAnchor.blendShapes['eyeBlink_R']!;
      // final smile = faceAnchor.blendShapes['toungeOut']!;

      if (smile > 0.5) {
        setState(() {
          faceStatus = 'Mouth Open';
        });
      } else {
        setState(() {
          faceStatus = 'Mouth Close';
        });
      }
    }
  }
}

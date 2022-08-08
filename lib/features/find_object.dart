import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/widgets/custom_button.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class FindObjectScreen extends StatefulWidget {
  const FindObjectScreen({Key? key}) : super(key: key);

  @override
  State<FindObjectScreen> createState() => _FindObjectScreenState();
}

class _FindObjectScreenState extends State<FindObjectScreen> {
  late ARKitController arkitController;
  ARKitSphere? sphere;
  Timer? timer;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft <= 30 && timeLeft > 0) {
          timeLeft = timeLeft - 1;
          if (timeLeft == 0) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Play Again'),
                    content: Text('Your score is $score'),
                    actions: [
                      CustomButton(
                        onPresssed: () {
                          setState(() {
                            timeLeft = 30;
                            score = 0;
                            startTimer();
                            Navigator.of(context).pop();
                          });
                        },
                        name: 'Play Again',
                      ),
                      CustomButton(
                        onPresssed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        name: 'OK',
                      ),
                    ],
                  );
                });
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    arkitController.dispose();
    timer?.cancel();
    super.dispose();
  }

  int score = 0;
  int timeLeft = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARKitSceneView(
            enableTapRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Score ' + score.toString(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(),
                  ),
                  Text(
                    timeLeft.toString() + 's',
                    style: Theme.of(context).textTheme.headline6?.copyWith(),
                  ),
                ],
              ),
            ),
          ),
          // if (timeLeft == 0)
          //   Center(
          //     child: InkWell(
          //         onTap: () {
          //           setState(() {
          //             timeLeft = 30;
          //             score = 0;
          //             arkitController.dispose();
          //             onARKitViewCreated(arkitController);
          //             startTimer();
          //           });
          //         },
          //         child: Text(
          //           'Play Again',
          //         )),
          //   )
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    this.arkitController = controller;

    // this.arkitController.onCameraDidChangeTrackingState =
    //     ((trackingState, reason) => {
    //       print(trackingState.)

    //     });
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);

    sphere = ARKitSphere(
      radius: 0.05,
      materials: [
        ARKitMaterial(
          lightingModelName: ARKitLightingModel.lambert,
          doubleSided: true,
          diffuse: ARKitMaterialProperty.image(
            'assets/football.jpg',
          ),
          // diffuse: ARKitMaterialProperty.color(Colors.red),
        ),
      ],
    );

    final node = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0.5, 0.5, 0.5),
      name: 'Sphere',
    );
    this.arkitController.add(node);
  }

  onNodeTapHandler(List<String> nodes) {
    vector.Vector3 randomVector = new vector.Vector3(
      math.Random().nextDouble(),
      math.Random().nextDouble(),
      math.Random().nextDouble(),
    );
    final name = nodes.first;
    setState(() {
      score = score + 1;
    });

    final randomColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    sphere!.radius.value = 0.05;
    sphere!.materials.value = [
      ARKitMaterial(
        lightingModelName: ARKitLightingModel.lambert,
        diffuse: ARKitMaterialProperty.image('assets/football.jpg'),
      ),
    ];
    print(randomVector);
    final newNode = ARKitNode(
      geometry: sphere,
      position: randomVector,
    );
    arkitController.update(
      name,
      node: newNode,
    );
  }
}

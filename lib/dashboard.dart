import 'package:flutter/material.dart';
import 'package:flutter_ar/features/all_geometry.dart';
import 'package:flutter_ar/features/custom_frame.dart';
import 'package:flutter_ar/features/custom_object.dart';
import 'package:flutter_ar/features/dragon.dart';
import 'package:flutter_ar/features/face_detection.dart';
import 'package:flutter_ar/features/find_object.dart';
import 'package:flutter_ar/features/geometry_shapes.dart';
import 'package:flutter_ar/features/image_diffuse.dart';
import 'package:flutter_ar/widgets/custom_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Ar'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GeometryShapesScreen()));
              },
              name: 'Geometry Shapes',
            ),
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllGeometryPage(),
                ));
              },
              name: 'All Geometry Shapes',
            ),
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDiffuseScreen(),
                ));
              },
              name: 'Image Diffuse',
            ),
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FindObjectScreen(),
                ));
              },
              name: 'Tap Event',
            ),
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomDragon(),
                ));
              },
              name: 'Dragon',
            ),

            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FaceDetectionScreen()));
              },
              name: 'Face Detection',
            ),
            CustomButton(
              onPresssed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomFrame(),
                ));
              },
              name: 'Custom Frame',
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => CustomObjectPage()));
            //   },
            //   child: Container(
            //     height: 40,
            //     decoration: BoxDecoration(
            //       color: Colors.blue[300],
            //     ),
            //     child: Center(
            //       child: Text('Custom Object',
            //           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //                 color: Colors.white,
            //               )),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

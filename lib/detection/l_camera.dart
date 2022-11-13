import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:camera_test/detection/b_b.dart';
import 'package:camera_test/detection/camera.dart';

class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  const LiveFeed(this.cameras, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;

  get controller => null;
  initCameras() async {}
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/detect.tflite",
      labels: "assets/labelmap.txt",
    );
  }

  /* 
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) async {
    setState(() {
      _recognitions = recognitions;
      //value size image yang detected
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });

    //stop stream camera n amik gambar
    controller.stopImageStream();
    XFile image = await controller.takePicture();
    image.saveTo(image.path);
    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
          imagePath: image.path,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Time Object Detection"),
        backgroundColor: const Color.fromARGB(255, 95, 204, 255),
      ),
      body: Stack(
        children: <Widget>[
          CameraFeed(widget.cameras, setRecognitions),
          BoundingBox(
            _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}

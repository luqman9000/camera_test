import 'package:camera/camera.dart';
import 'package:camera_test/Camera_2/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:camera_test/Camera_2/scan_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CameraScreen extends GetView<ScanController> {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(builder: (controller){
      if (!controller.value.isInitialized){
        return Container();
      }
      return MaterialApp(
        home: CameraPreview(controller),
        );
    })
    return Container();
  }

}

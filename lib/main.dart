// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:camera_test/detection/l_camera.dart';
import 'package:camera_test/Camera_2/camera2.dart';

/*List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}*/

//untuk camera 1 dengan 2
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raised Button',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String istapped = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeeksforGeeks'),
        backgroundColor: const Color.fromARGB(255, 95, 204, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // RaisedButton has been deprecated
            // We can use Elevated button achieve the same results
            ElevatedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 95, 204, 255), // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraPage()));
              },
              child: const Text('Start license plate detection'),
            ),
            //test camera lain
            ElevatedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 95, 204, 255), // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const camera2()));
              },
              child: const Text(
                  'Start license plate detection("another one" - dj khaled)'),
            ),
            const SizedBox(
              height: 20,
            ),
            // ElevatedButton
            const SizedBox(height: 20),
            Text(
              istapped,
              textScaleFactor: 2,
            )
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
        backgroundColor: const Color.fromARGB(255, 95, 204, 255),
      ),
      body: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 95, 204, 255), // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LiveFeed(cameras)));
              },
              child: const Text('Start camera'))),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}

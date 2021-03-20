import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_detector_app/splash_screen_page.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Detector',
      home: SplashScreenPage(),
    );
  }
}

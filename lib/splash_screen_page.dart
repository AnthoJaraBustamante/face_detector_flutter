import 'package:flutter/material.dart';
import 'package:flutter_face_detector_app/g.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: Text(
        '\n DETECCIÓN DE ROSTROS',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      image: Image.asset('assets/splash.png'),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        'By Ajarab',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

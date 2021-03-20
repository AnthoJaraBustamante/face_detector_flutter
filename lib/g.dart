import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_detector_app/utils/utils_scanner.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController cameraController;
  CameraDescription cameraDescription;
  CameraLensDirection cameraLensDirection = CameraLensDirection.back;
  FaceDetector faceDetector;
  bool isWorking = false;
  Size size;
  List<Face> faceList;

  initCamera() async {
    cameraDescription = await UtilsScanner.getCamera(cameraLensDirection);

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);

    faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        minFaceSize: 0.1,
        mode: FaceDetectorMode.fast,
      ),
    );

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
    });

    cameraController.startImageStream((imageFromStream) {
      if (!isWorking) {
        isWorking = true;

        //implementr FaceDetection
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController?.dispose();
    faceDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackWidgetChildren = [];
    size = MediaQuery.of(context).size;
    // add streaming camera
    if (cameraController != null) {
      stackWidgetChildren.add(Positioned(
        top: 30,
        left: 0,
        width: size.width,
        height: size.height - 250,
        child: Container(
          child: (cameraController.value.isInitialized)
              ? AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                )
              : Container(),
        ),
      ));
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 0),
        color: Colors.black,
        child: Stack(
          children: stackWidgetChildren,
        ),
      ),
    );
  }
}

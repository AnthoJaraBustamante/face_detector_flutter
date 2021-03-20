import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UtilsScanner {
  UtilsScanner._();

  static Future<CameraDescription> getCamera(
      CameraLensDirection cameraLensDirection) async {
    return await availableCameras().then((List<CameraDescription> cameras) {
      return cameras.firstWhere((CameraDescription cameraDescription) {
        return cameraDescription.lensDirection == cameraLensDirection;
      });
    });
  }

  static Future<dynamic> detect(
      CameraImage image,
      Future<dynamic> Function(FirebaseVisionImage image) detectInImage,
      int imageRotation) async {
    return detectInImage(FirebaseVisionImage.fromBytes(
        concatenatePlanes(image.planes),
        buildMetadata(image, rotationValToImageRotation(imageRotation))));
  }

  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();

    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static FirebaseVisionImageMetadata buildMetadata(
      CameraImage image, ImageRotation rotationValToImageRotation) {
    return FirebaseVisionImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rawFormat: image.format.raw,
        planeData: image.planes.map((Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width);
        }));
  }

  static ImageRotation rotationValToImageRotation(int imageRotation) {
    switch (imageRotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(imageRotation == 270);
        return ImageRotation.rotation270;
    }
  }
}

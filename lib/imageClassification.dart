import 'dart:io';

import 'package:tflite/tflite.dart';

class ImageClassification {
  ImageClassification._privateConstructor();

  static final ImageClassification instance =
      ImageClassification._privateConstructor();

  Future imageClassification(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    return prediction;
  }
}

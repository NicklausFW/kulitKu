import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class SelectImage {
  SelectImage._privateConstructor();

  static final SelectImage instance = SelectImage._privateConstructor();

  pickImage(ImageSource source) async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage == null) return;
      return File(selectedImage.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

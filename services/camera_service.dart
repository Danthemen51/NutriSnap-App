import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraService {
  static final ImagePicker _imagePicker = ImagePicker();

  // Initialize camera
  static Future<CameraController?> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      return CameraController(
        firstCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
      return null;
    }
  }

  // Take picture using camera
  static Future<XFile?> takePicture(CameraController controller) async {
    try {
      if (!controller.value.isInitialized) {
        return null;
      }

      final XFile file = await controller.takePicture();
      return file;
    } catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
      return null;
    }
  }

  // Pick image from gallery
  static Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );
      return image;
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image from gallery: $e');
      }
      return null;
    }
  }

  // Save image to app directory
  static Future<String?> saveImageToAppDirectory(XFile imageFile) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = 'food_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String savedImagePath = path.join(appDir.path, fileName);

      final File savedImage = File(savedImagePath);
      await savedImage.writeAsBytes(await imageFile.readAsBytes());

      return savedImagePath;
    } catch (e) {
      if (kDebugMode) {
        print('Error saving image: $e');
      }
      return null;
    }
  }

  // Convert XFile to File
  static Future<File?> xFileToFile(XFile xfile) async {
    try {
      return File(xfile.path);
    } catch (e) {
      if (kDebugMode) {
        print('Error converting XFile to File: $e');
      }
      return null;
    }
  }
}
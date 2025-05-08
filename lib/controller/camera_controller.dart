import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class CameraController extends ChangeNotifier{

  final Map<String, List<String>> _photosMap = {
    "id": [],
    "profession_license": [],
    "commercial_registration": [],
  };

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<String> getPhotosByType(String photoType) {
    return _photosMap[photoType] ?? [];
  }

  Future<void> pickImage(String photoType) async {
    if (getPhotosByType(photoType).length >= 2) {
      _errorMessage = "You can only upload two images.";
      notifyListeners();
      return;
    }

    try {
      final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);

        XFile compressedImage = await _compressImage(imageFile);

        final Uint8List imageBytes = await compressedImage.readAsBytes();

        _photosMap[photoType]?.add(base64Encode(imageBytes));
        _errorMessage = null;
        notifyListeners();
      }
    } catch (e) {
      print("Error picking or compressing image: $e");
    }
  }

  void removeImage(String base64String, String photoType) {
    _photosMap[photoType]?.remove(base64String);
    notifyListeners();
  }

  void clearImages(String photoType) {
    _photosMap[photoType]?.clear();
    notifyListeners();
  }

  Future<XFile> _compressImage(File imageFile) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      imageFile.absolute.path.replaceAll('.jpg', '_compressed.jpg'),
      quality: 50,
      minWidth: 800,
      minHeight: 600,
    );

    if (compressedFile == null) {
      throw Exception("Failed to compress image.");
    }

    return compressedFile;
  }
}
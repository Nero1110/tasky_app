import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:depi_flutter_3rd_task/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoPicker {
  Future<void> pickProfileImage() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    if (!status.isGranted) {
      
      snackbarKey.currentState!.showSnackBar(SnackBar(content: Text("Allow Access in Setting if you want to change photo")));
      return;
    }

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    }

    final bytes = await pickedImage.readAsBytes();
    final base64Image = base64Encode(bytes);

    var box = Hive.box('ImageBox');
    await box.put('profileImage', base64Image);
  }

  Future<Uint8List> loadAssetImageBytes(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }
}

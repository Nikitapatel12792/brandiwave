import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> pickImage() async {
  bool hasPermission = await requestPermissions();

  if (!hasPermission) {
    Fluttertoast.showToast(
      msg: "Permission denied! Please enable access to pick an image.",
      fontSize: 14,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
    return null;
  }

  ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

  if (photo != null) {
    return File(photo.path);
  } else {
    Fluttertoast.showToast(
      msg: "No image selected",
      fontSize: 14,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
    return null;
  }
}

Future<bool> requestPermissions() async {
  if (Platform.isAndroid) {
    // Request storage permission (for Android 10 and below)
    var storageStatus = await Permission.storage.request();
    if (storageStatus.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    // For Android 11+ (Scoped Storage)
    var manageStatus = await Permission.manageExternalStorage.request();
    if (manageStatus.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return storageStatus.isGranted || manageStatus.isGranted;
  }

  if (Platform.isIOS) {
    var photoStatus = await Permission.photos.request();
    if (photoStatus.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return photoStatus.isGranted;
  }

  return false;
}

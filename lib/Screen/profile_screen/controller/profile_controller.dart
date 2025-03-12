import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class ProfileController extends GetxController {
  Rxn<File> selectedimage = Rxn<File>();
  SignatureController scontroller = SignatureController(
    penColor: Colors.black, // Set pen color
    penStrokeWidth: 5, // Set pen stroke width
    exportBackgroundColor: Colors.transparent, // Set background color
  );
  Rx<Uint8List?> signatureImage = Rx<Uint8List?>(null);
  final RxString selectedjobFunction = "".obs;
  final RxString selectedjobLevel = "".obs;
  final RxString selectedLanguage = "".obs;
  RxBool obsecure = false.obs;
  RxBool isChecked = false.obs;
  RxList<String> jobFunction = ["Option 1", "Option 2", "Option 3"].obs;
  RxList<String> jobLevel = ["Executive", "Manager", "Senior Manager"].obs;
  RxList<String> language = ["English", "Hindi", "Tamil"].obs;
  TextEditingController password = TextEditingController();
}

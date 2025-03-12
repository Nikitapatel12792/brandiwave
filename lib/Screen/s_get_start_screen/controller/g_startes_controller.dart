import 'package:brandiwave/Screen/sign_up_screen/controller/sign_up_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SstartedController extends GetxController {
  RxBool obsecure = false.obs;
  final RxString selectedjobFunction = "".obs;
  final RxString selectedJobLevel = "".obs;
  RxBool isChecked = false.obs;
  RxList<String> jobFunction = ["Option 1", "Option 2", "Option 3"].obs;
  RxList<String> jobLevel = ["Executive", "Manager", "Senior Manager"].obs;
  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fullname.text = SignUpController().fullName.value;
  }

  String? validatePassword(String password) {
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter (A-Z)";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter (a-z)";
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must contain at least one number (0-9)";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Password must contain at least one special character (!@#\$%^&*)";
    }
    return null; // ✅ Password is valid
  }
}

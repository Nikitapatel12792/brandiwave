import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController{
  TextEditingController newPass=TextEditingController();
  TextEditingController confirmPass=TextEditingController();
  RxBool newpass=false.obs;
  RxBool confirmpass=false.obs;
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  RxBool obsecure=false.obs;
}
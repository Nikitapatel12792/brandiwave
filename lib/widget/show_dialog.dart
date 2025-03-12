import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/custom_color.dart';
import 'custom_elevated_button.dart';

void showCustomDialog(
    {required String title,
    required String desc,
    required VoidCallback onYes,
    required VoidCallback onNo}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(desc),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                text: "Yes",
                height: 40.px,
                buttonColor: black,
                textColor: white,
                width: 100.px,
                onTap: onYes,
              ),
              CustomElevatedButton(
                text: "No",
                height: 40.px,
                buttonColor: appColor,
                textColor: white,
                width: 100.px,
                onTap: onNo,
              )
            ],
          )
        ],
      ),
    ),
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
  );
}

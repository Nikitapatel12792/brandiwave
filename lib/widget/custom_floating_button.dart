import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/custom_color.dart';
import 'custom_elevated_button.dart';

Widget customFloatinfButton(
    {required String title, IconData? icon, required VoidCallback ontap}) {
  return SizedBox(
    width: 150.px,
    child: FloatingActionButton(
      onPressed: () {},
      backgroundColor: appColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.px)),
      child: CustomElevatedButton(
        buttonColor: appColor,
        textColor: white,
        text: ' $title',
        onTap: ontap,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.px)),
        buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.px))),
        width: 150.px,
        leftIcon: Icon(
          icon,
          color: white,
        ),
      ),
    ),
  );
}

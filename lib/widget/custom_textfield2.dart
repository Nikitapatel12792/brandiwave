import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget customTextField({
  required bool obsecure,
  required Widget child,
  required TextEditingController controller,
  required String title,
  required String hint,
  TextInputType? keyboard,
  int? maxline,
  required FormFieldValidator<String> validator, // Added validator parameter
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.isNotEmpty
          ? Text(
              title,
              style: AppTextStyle.pw600.copyWith(
                color: darkGrey,
                fontSize: 12.px,
              ),
            )
          : SizedBox(),
      title.isNotEmpty ? SizedBox(height: 1.h) : SizedBox(),
      CustomTextfield(
        obsecure: obsecure,
        controller: controller,
        hint: hint,
        validator: validator,
        maxLine: maxline ?? 1,
      )
    ],
  );
}

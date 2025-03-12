import 'package:brandiwave/Screen/home_screen/controller/home_controller.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildSegmentedControl() {
  return Container(
    height: 50.px,
    decoration: BoxDecoration(
      color: lightAppColor,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSegment("Daily", 0),
        _buildSegment("Weekly", 1),
        _buildSegment("Monthly", 2),
      ],
    ),
  );
}

Widget _buildSegment(String text, int index) {
  var controller = Get.put(HomeController());
  return Expanded(
    child: Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedDurationIndex.value = index;
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: controller.selectedDurationIndex.value == index
                ? Colors.black
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: AppTextStyle.pw400.copyWith(
                color: controller.selectedDurationIndex.value == index
                    ? white
                    : textGrey),
          ),
        ),
      ),
    ),
  );
}

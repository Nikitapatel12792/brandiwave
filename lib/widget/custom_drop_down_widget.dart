import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData icon;
  final RxString selectedValue;
  final double borderRadius;
  final String? title;
  final String? message;
  final String? hint;
  final FormFieldValidator<String>? validator;

  const CustomDropdown({
    this.hint,
    super.key,
    this.message,
    this.title,
    required this.items,
    required this.selectedValue,
    this.hintText = "Select an item",
    this.icon = Icons.arrow_drop_down,
    this.validator,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: AppTextStyle.pw600.copyWith(
              color: darkGrey,
              fontSize: 12.px,
            ),
          ),
        if (title != null) SizedBox(height: 1.h),
        Obx(
          () => DropdownButtonFormField<String>(
            style: AppTextStyle.pw400.copyWith(
              fontSize: 14.px,
              color: Colors.grey.shade600,
            ),
            decoration: InputDecoration(
              errorStyle: AppTextStyle.pw400.copyWith(
                fontSize: 12.px,
                color: Colors.red,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.px),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.px),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.px),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return message;
              }
              return null;
            }, // Keep validator here
            dropdownColor: white,
            borderRadius: BorderRadius.circular(10.px),
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(hintText),
            icon: Icon(icon, color: Colors.grey.shade600),
            isExpanded: true,
            onChanged: (newValue) {
              selectedValue.value = newValue!;
            },
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: AppTextStyle.pw400.copyWith(
                          fontSize: 14.px,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

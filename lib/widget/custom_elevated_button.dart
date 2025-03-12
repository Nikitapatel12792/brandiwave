import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/base_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onTap,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.buttonColor,
    super.textColor,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 7.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? appColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.px))),
          onPressed: isDisabled ?? false ? null : onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    AppTextStyle.pw700
                        .copyWith(color: textColor ?? white, fontSize: 14.px),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}

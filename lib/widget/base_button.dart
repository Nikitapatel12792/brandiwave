import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(
      {super.key,
      required this.text,
      this.onTap,
      this.buttonStyle,
      this.buttonTextStyle,
      this.isDisabled,
      this.height,
      this.width,
      this.margin,
      this.alignment,
      this.buttonColor,
      this.textColor});

  final String text;

  final VoidCallback? onTap;

  final ButtonStyle? buttonStyle;

  final TextStyle? buttonTextStyle;

  final bool? isDisabled;
  final Color? buttonColor;
  final Color? textColor;

  final double? height;

  final double? width;

  final EdgeInsets? margin;

  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

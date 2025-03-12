import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class CustomTextfield extends HookWidget {
  final bool obsecure;
  final TextEditingController controller;

  final String hint;
  final Widget child;
  final int maxLine;
  final FormFieldValidator<String>? validator;

  const CustomTextfield({
    super.key,
    this.child = const SizedBox(),
    this.maxLine = 1,
    this.obsecure = false,
    required this.controller,
    required this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isObsecure = useState(false);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.px),
      borderSide: BorderSide(color: textFieldBorder),
    );

    return TextFormField(
      maxLines: maxLine,
      obscureText: obsecure && isObsecure.value,
      controller: controller,
      style: AppTextStyle.pw500.copyWith(fontSize: 14.px, color: textFieldHint),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        suffixIcon: obsecure
            ? IconButton(
                onPressed: () => isObsecure.value = !isObsecure.value,
                icon: Icon(
                    isObsecure.value ? Icons.visibility : Icons.visibility_off,
                    color: textFieldHint),
              )
            : child,
        hintText: hint,
        errorStyle: AppTextStyle.pw400.copyWith(
          fontSize: 12.px,
          color: Colors.red,
        ),
        hintStyle:
            AppTextStyle.pw500.copyWith(fontSize: 14.px, color: textFieldHint),
        border: border,
        enabledBorder: border,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.px),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: border,
      ),
      validator: validator,
    );
  }
}

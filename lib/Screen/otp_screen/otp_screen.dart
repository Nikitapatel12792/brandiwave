import 'package:brandiwave/Screen/new_password_screen/new_password_screen.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0XFF81E7D5),
                  Color(0XFF81E7D5),
                  Color(0XFF81E7D5),
                  appColor,
                  appColor
                ])),
          ),
          Positioned(
            top: 7.h, // Move image down by 7.h
            left: 0,
            right: 0,
            child: Center(
              // Ensures image is centered horizontally
              child: CustomImageView(
                fit: BoxFit.cover,
                imagePath: ImageConstant.appLogo,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.px),
                    topRight: Radius.circular(30.px),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: Text(
                      "Verification",
                      style: AppTextStyle.pw600
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      "Enter Verification Code",
                      style: AppTextStyle.pw500
                          .copyWith(color: Colors.grey.shade500),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        selectedFillColor: Colors.white,
                        // disabledColor: Colors.black,
                        inactiveColor: grey,
                        inactiveFillColor: Colors.white,
                        activeBorderWidth: 2,
                        selectedBorderWidth: 2,
                        disabledBorderWidth: 2,
                        activeFillColor: Colors.white,
                        selectedColor: appColor,
                        activeColor: Colors.black),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    enablePinAutofill: true,
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you don't receive code. ",
                        style: AppTextStyle.pw400
                            .copyWith(color: Colors.grey.shade400),
                      ),
                      Text(
                        "Resend",
                        style: AppTextStyle.pw400
                            .copyWith(color: Colors.blueAccent),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomElevatedButton(
                    text: "Submit",
                    height: 50.px,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Get.to(() => NewPasswordScreen());
                      }
                    },
                    buttonColor: appColor,
                    textColor: white,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Cancel",
                          style:
                              AppTextStyle.pw500.copyWith(color: Colors.grey),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

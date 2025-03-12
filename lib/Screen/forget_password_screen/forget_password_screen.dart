import 'package:brandiwave/Screen/forget_password_screen/controller/forget_pass_controller.dart';
import 'package:brandiwave/Screen/otp_screen/otp_screen.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:brandiwave/widget/custom_textfield2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final controller = Get.put(ForgetPassController());
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
            width: MediaQuery.of(context).size.width,
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
            bottom: 0, // Allow it to stretch to the bottom of the screen
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.px),
                      topLeft: Radius.circular(30.px))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Text(
                        "Password Recovery",
                        style: AppTextStyle.pw600
                            .copyWith(color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Form(
                      key: formKey,
                      child: customTextField(
                          validator: (value) {
                            String p =
                                "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                            RegExp regExp = RegExp(p);
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else {
                              //If email address matches pattern
                              if (regExp.hasMatch(value)) {
                                return null;
                              } else {
                                //If it doesn't match
                                return 'Email is not valid';
                              }
                            }
                          },
                          child: SizedBox(),
                          obsecure: false,
                          hint: "Type your Email",
                          controller: controller.email,
                          title:
                              "Please enter your email to receive your password reset instruction "),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Our Contacts",
                      style: AppTextStyle.pw600
                          .copyWith(color: black, fontSize: 14.px),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Click on contact to copy it",
                      style: AppTextStyle.pw400.copyWith(
                          color: Colors.grey.shade600, fontSize: 12.px),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.phone,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "1800 0000 0000",
                          style: AppTextStyle.pw400.copyWith(
                              color: Colors.grey.shade600, fontSize: 12.px),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.mail,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "support@gmail.com",
                          style: AppTextStyle.pw400
                              .copyWith(color: Colors.orange, fontSize: 12.px),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomElevatedButton(
                      text: "Submit",
                      height: 50.px,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Get.to(() => OtpScreen());
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
                            style: AppTextStyle.pw500
                                .copyWith(color: Colors.black),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

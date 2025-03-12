import 'package:brandiwave/Screen/s_get_start_screen/s_get_started_screen.dart';
import 'package:brandiwave/Screen/sign_in_screen/sign_in_screen.dart';
import 'package:brandiwave/Screen/sign_up_screen/controller/sign_up_controller.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:brandiwave/widget/custom_textfield.dart';
import 'package:brandiwave/widget/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(SignUpController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GradientContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Positioned(
                top: 7.h, // Move image down by 7.h
                left: 0,
                right: 0,
                child: Center(
                  // Ensures image is centered horizontally
                  child: CustomImageView(
                    fit: BoxFit.cover,
                    imagePath: ImageConstant.splashBack,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.px),
                          topRight: Radius.circular(20.px))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Sign Up",
                          style: AppTextStyle.pw500
                              .copyWith(fontSize: 20.px, color: black),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Let's set up your account",
                          style: AppTextStyle.pw400.copyWith(color: darkGrey),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Form(
                          key: formKey,
                          child: CustomTextfield(
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
                            obsecure: false,
                            controller: controller.email,
                            hint: "Email Address",
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomElevatedButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Get.to(() => SGetStartedScreen());
                            }
                          },
                          height: 50.px,
                          text: "Sign Up",
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Colors.grey.shade300,
                            )),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Or Sign up with",
                              style: AppTextStyle.pw400
                                  .copyWith(color: textGrey, fontSize: 12.px),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.grey.shade300,
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomImageView(
                              onTap: () {
                                controller.signInWithGoogle();
                              },
                              imagePath: ImageConstant.iconGoogle,
                              height: 40.px,
                              width: 40.px,
                            ),
                            CustomImageView(
                              onTap: () {
                                controller.signIn();
                              },
                              imagePath: ImageConstant.iconMicrosoft,
                              height: 40.px,
                              width: 40.px,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: AppTextStyle.pw600
                                  .copyWith(color: darkGrey, fontSize: 14.px),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SignInScreen());
                              },
                              child: Text(
                                " Login now",
                                style: AppTextStyle.pw600
                                    .copyWith(color: appColor, fontSize: 14.px),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

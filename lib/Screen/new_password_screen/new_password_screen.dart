import 'package:brandiwave/Screen/new_password_screen/controller/new_password_controller.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:brandiwave/widget/custom_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var controller = Get.put(NewPasswordController());
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: Text(
                        "New Password",
                        style: AppTextStyle.pw600
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => customTextField(
                          obsecure: controller.newpass.value,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          title: "New Password",
                          controller: controller.newPass,
                          hint: "New Password",
                          child: GestureDetector(
                            onTap: () {
                              controller.newpass.value =
                                  !controller.newpass.value;
                            },
                            child: Icon(
                              controller.newpass.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.shade600,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(
                      () => customTextField(
                          obsecure: controller.confirmpass.value,
                          title: "Confirm Password",
                          controller: controller.confirmPass,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          hint: "Confirm Password",
                          child: GestureDetector(
                            onTap: () {
                              controller.confirmpass.value =
                                  !controller.confirmpass.value;
                            },
                            child: Icon(
                              controller.confirmpass.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey.shade600,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomElevatedButton(
                      text: "Submit",
                      height: 50.px,
                      onTap: () {
                        if (formKey.currentState!.validate()) {}
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
          ),
        ],
      ),
    );
  }
}

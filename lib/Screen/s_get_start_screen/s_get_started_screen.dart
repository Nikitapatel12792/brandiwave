import 'package:brandiwave/Screen/home_container_screen/home_container_screen.dart';
import 'package:brandiwave/Screen/s_get_start_screen/controller/g_startes_controller.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_drop_down_widget.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_textfield2.dart';
import 'package:brandiwave/widget/gradient_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SGetStartedScreen extends StatelessWidget {
  SGetStartedScreen({super.key});
  final controller = Get.put(SstartedController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.px),
                  topLeft: Radius.circular(30.px))),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: Text(
                      " Welcome to Brandiwave",
                      style: AppTextStyle.pw500
                          .copyWith(fontSize: 20.px, color: darkGrey),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  customTextField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter fullname";
                        }
                        return null;
                      },
                      child: SizedBox(),
                      obsecure: false,
                      hint: "Full Name",
                      controller: controller.fullname,
                      title: "Full Name"),
                  SizedBox(
                    height: 2.h,
                  ),
                  customTextField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter a password";
                      }
                      return controller.validatePassword(
                          val); // Call the validation function
                    },
                    obsecure: true,
                    hint: "Password",
                    controller: controller.password,
                    title: "Password",
                    child: GestureDetector(
                      onTap: () {
                        controller.obsecure.value = !controller.obsecure.value;
                      },
                      child: Icon(
                        controller.obsecure.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomDropdown(
                    message: "Please select the job function",
                    title: "Job Function",
                    hintText: "Select Job Function",
                    items: controller.jobFunction,
                    selectedValue: controller.selectedjobFunction,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomDropdown(
                    message: "Please select the job level",
                    title: "Job Level",
                    hintText: "Select Job Level",
                    items: controller.jobLevel,
                    selectedValue: controller.selectedJobLevel,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  customTextField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter mobile number";
                        } else if (val.length != 10) {
                          return "Please enter valid mobile number";
                        }
                        return null;
                      },
                      hint: "Mobile Number",
                      controller: controller.mobile,
                      child: SizedBox(),
                      obsecure: false,
                      title: "Mobile Number"),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value!;
                            },
                            activeColor: appColor,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14), // Default text style
                                children: [
                                  TextSpan(
                                      text: "I've read and agree with the ",
                                      style: AppTextStyle.pw400
                                          .copyWith(color: textGrey)),
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    style: AppTextStyle.pw600.copyWith(
                                        color: appColor, fontSize: 12.px),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print(
                                          "Terms and Conditions Clicked!",
                                        );
                                        // Navigate to Terms & Conditions page
                                      },
                                  ),
                                  TextSpan(
                                      text: " and the ",
                                      style: AppTextStyle.pw400
                                          .copyWith(color: textGrey)),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: AppTextStyle.pw600.copyWith(
                                        color: appColor, fontSize: 12.px),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Privacy Policy Clicked!");
                                        // Navigate to Privacy Policy page
                                      },
                                  ),
                                  TextSpan(text: "."),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  if (formKey.currentState?.validate() == false)
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "You must accept the terms to proceed",
                        style: AppTextStyle.pw400.copyWith(
                          fontSize: 12.px,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomElevatedButton(
                    text: "Get Started",
                    height: 50.px,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Get.to(() => HomeContainerScreen());
                      }
                    },
                    buttonColor: appColor,
                    textColor: white,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

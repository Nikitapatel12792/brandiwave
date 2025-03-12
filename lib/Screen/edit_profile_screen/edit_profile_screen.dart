import 'dart:io';
import 'dart:ui';

import 'package:brandiwave/Screen/profile_screen/controller/profile_controller.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_drop_down_widget.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_textfield2.dart';
import 'package:brandiwave/widget/select_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';

import '../../widget/custom_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.put(ProfileController());
  ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.menu,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "My Profile",
                          style: AppTextStyle.pw600.copyWith(color: white),
                        )
                      ],
                    ),
                    Icon(
                      Icons.notifications_none_outlined,
                      color: white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Juan Gomez",
                              style: AppTextStyle.pw600.copyWith(color: white)),
                          Text("JuanGomez@teqinvelly.com",
                              style: AppTextStyle.pw400.copyWith(color: white))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.27,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.px),
                      topLeft: Radius.circular(30.px),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomDropdown(
                          message: "Please select the job function",
                          icon: Icons.keyboard_arrow_down,
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
                          icon: Icons.keyboard_arrow_down,
                          title: "Job Level",
                          hintText: "Select Job Level",
                          items: controller.jobLevel,
                          selectedValue: controller.selectedjobLevel,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomDropdown(
                          message: "Please select the language",
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please select the language";
                            }
                            return null;
                          },
                          icon: Icons.keyboard_arrow_down,
                          title: "Language",
                          hintText: "Select Language",
                          items: controller.language,
                          selectedValue: controller.selectedLanguage,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(
                          () => customTextField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter password";
                              }
                              return null;
                            },
                            obsecure: controller.obsecure.value,
                            hint: "Password",
                            controller: controller.password,
                            title: "Password",
                            child: GestureDetector(
                              onTap: () {
                                controller.obsecure.value =
                                    !controller.obsecure.value;
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
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Signature",
                                  style: AppTextStyle.pw400.copyWith(
                                      color: Colors.grey.shade600,
                                      fontSize: 16.px),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      signatureDialog();
                                    },
                                    child: Text(
                                      "+Signature",
                                      style: AppTextStyle.pw600.copyWith(
                                          color: Colors.blueAccent,
                                          fontSize: 18.px),
                                    )),
                              ],
                            ),
                            Obx(() {
                              return controller.signatureImage.value == null
                                  ? SizedBox()
                                  : Container(
                                      width: 120
                                          .px, // Adjust the size of the displayed image
                                      height: 60.px,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
                                      ),
                                      child: Image.memory(
                                        controller.signatureImage
                                            .value!, // Display the signature as a byte array
                                        fit: BoxFit.contain,
                                      ),
                                    );
                            })
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
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
                                    AppTextStyle.pw500.copyWith(color: black),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Obx(
                  () => Center(
                      child: Container(
                    height: 120.px,
                    width: 120.px,
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // Ensures the container is circular
                      border: Border.all(color: appColor, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(60.px), // Half of height/width
                      child: controller.selectedimage.value == null
                          ? CustomImageView(
                              fit: BoxFit.cover,
                              url:
                                  "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg",
                            )
                          : CustomImageView(
                              fit: BoxFit.cover,
                              file: controller.selectedimage.value,
                            ),
                    ),
                  )),
                ),
                GestureDetector(
                  onTap: () async {
                    File? selectedImage = await pickImage();
                    if (selectedImage != null) {
                      controller.selectedimage.value = selectedImage;
                    }
                  },
                  child: Container(
                    width: 30.px,
                    height: 30.px,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: appColor),
                    child: Icon(
                      Icons.edit,
                      color: white,
                      size: 20.px,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  signatureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: white,
          title: Text("Sign Here"),
          content: SingleChildScrollView(
            // Allow scrolling if content is too large
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300, // Set width
                  height: 300, // Set height
                  child: Signature(
                    controller: controller.scontroller,
                    backgroundColor: Colors.grey[200]!,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        height: 50.px,
                        width: 100.px,
                        buttonColor: appColor,
                        textColor: white,
                        text: "Clear",
                        onTap: () async {
                          controller.signatureImage.value = null;
                          controller.scontroller.clear();
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Save",
                        height: 50.px,
                        width: 100.px,
                        buttonColor: appColor,
                        textColor: white,
                        onTap: () async {
                          // Get the signature as an image (PNG format)
                          final signature =
                              await controller.scontroller.toImage();

                          // Convert the signature to byte data (PNG format)
                          final byteData = await signature?.toByteData(
                              format: ImageByteFormat.png);

                          // Ensure byteData is not null before proceeding
                          if (byteData != null) {
                            final buffer = byteData.buffer.asUint8List();

                            // Store the signature image in the controller
                            controller.signatureImage.value = buffer;

                            // Close the dialog after saving
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

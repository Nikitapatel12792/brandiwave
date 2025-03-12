import 'package:brandiwave/Screen/on_boarding_two_screen/on_bording_two_screen.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OnBoardingOneScreen extends StatelessWidget {
  const OnBoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          // Spacer(),
          Center(
            child: Transform.scale(
              scale: 2, // Scale the image 1.5 times
              child: CustomImageView(
                fit: BoxFit.cover,
                imagePath: ImageConstant.splashBack,
                color: Color(0XFF38A6F7).withOpacity(0.25),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  fit: BoxFit.cover,
                  imagePath: ImageConstant.appLogo,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(
                    " Welcome to Cust exp project",
                    style: AppTextStyle.pw700
                        .copyWith(fontSize: 20.px, color: black),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Your all-in-one social \n  media management platform",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.pw500
                      .copyWith(fontSize: 14.px, color: black),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment
                .bottomCenter, // Centers horizontally and places it at bottom
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h), // Add bottom spacing
              child: GestureDetector(
                onTap: () {
                  Get.to(() => OnBoardingTwoScreen());
                },
                child: Container(
                  height: 50.px,
                  width: 50.px,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appColor,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.px,
                    color: white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:brandiwave/Screen/on_boarding_three_screen/controller/on_board_controller.dart';
import 'package:brandiwave/Screen/sign_up_screen/sign_up_screen.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/image_constants.dart';

class OnBoardingThreeScreen extends StatelessWidget {
  OnBoardingThreeScreen({super.key});
  final controller = Get.put(OnBoardController());
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
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0, // Set height
                    autoPlay: false, // Auto slide
                    enlargeCenterPage: false, // Zoom effect
                    aspectRatio: 16 / 9, // Aspect ratio
                    onPageChanged: (index, reason) {
                      controller.currentIndex.value = index;
                    },
                  ),
                  items: [
                    ImageConstant.sliderOne,
                    ImageConstant.sliderTwo,
                    ImageConstant.sliderThree,
                    ImageConstant.sliderFour
                  ].map((imageUrl) {
                    return CustomImageView(
                      imagePath: imageUrl,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Schedule posts across multiple \n social media platforms",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.pw500
                      .copyWith(fontSize: 14.px, color: black),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => AnimatedSmoothIndicator(
                    activeIndex: controller.currentIndex.value,
                    count: 4,
                    effect: WormEffect(
                        activeDotColor: appColor,
                        radius: 10.px,
                        dotHeight: 10.px,
                        dotWidth: 10.px),
                    onDotClicked: (index) {
                      print(index);
                      controller.currentIndex.value = index;
                    },
                  ),
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
                  Get.to(() => SignUpScreen());
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

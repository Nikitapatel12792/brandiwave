import 'package:brandiwave/Screen/on_boarding_one_screen/on_boarding_one_screen.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Extended to 5 seconds
    );

    _scaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(OnBoardingOneScreen()); // Navigate after animation
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.5, -0.5),
              radius: 0.8,
              colors: [gradient1, gradient2],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// **Animated Splash Background**
              ScaleTransition(
                scale: _scaleAnimation,
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.splashBack,
                  ),
                ),
              ),

              /// **Text & Logo Section**
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      height: 50.px,
                      width: 210.px,
                      fit: BoxFit.contain,
                      imagePath: ImageConstant.appLogo,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "One Platform.",
                      style: AppTextStyle.pw600
                          .copyWith(fontSize: 14.px, color: white),
                    ),
                    Text(
                      "Endless Possibilities.",
                      style: AppTextStyle.pw600
                          .copyWith(fontSize: 14.px, color: white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

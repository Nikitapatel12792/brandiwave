import 'package:brandiwave/Screen/home_screen/controller/home_controller.dart';
import 'package:brandiwave/Screen/home_screen/widget/bar_chart_widget.dart';
import 'package:brandiwave/Screen/home_screen/widget/duration_widget.dart';
import 'package:brandiwave/Screen/home_screen/widget/pie_chart_widget.dart';
import 'package:brandiwave/Screen/profile_screen/profile_screen.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_bottom_bar.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:brandiwave/widget/drawer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/custom_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightAppColor,
      appBar: AppBar(
        backgroundColor: lightAppColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Opens Drawer
            },
            child: Icon(Icons.menu, color: appColor),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.notifications,
                color: appColor,
                size: 25.px,
              )),
          SizedBox(
            width: 3.w,
          ),
          GestureDetector(
              onTap: () {
                final BottomNavigationController controller1 =
                    Get.put(BottomNavigationController());
                controller1.changeIndex(3);

                controller1.onChange(ProfileScreen());
              },
              child: CustomImageView(
                imagePath: ImageConstant.profileIcon,
              )),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      drawer: CustomDrawer(onClose: () {
        Get.back(); // Close drawer on tap
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Text(
                "Welcome,",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px),
              ),
              Text(
                "Super Admin",
                style:
                    AppTextStyle.pw700.copyWith(color: black, fontSize: 14.px),
              ),
              SizedBox(height: 2.h),
              _buildStatsCards(),
              SizedBox(height: 2.h),
              _buildCarouselSlider(),
              // _buildPieChart(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return _statCard(
                image: controller.statsList[index].image ?? "",
                title: controller.statsList[index].title,
                count: controller.statsList[index].count.toString(),
                per: controller.statsList[index].per,
                color: controller.statsList[index].color);
          })),
    );
  }

  Widget _statCard(
      {required String title,
      required String count,
      required String per,
      String? image,
      required Color color}) {
    return Container(
      width: 145.px,
      height: 190.px,
      padding: EdgeInsets.all(1.5.h),
      margin: EdgeInsets.only(right: 5.w, top: 1, bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.px),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 1, offset: Offset(0.2, 0.2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 50.px,
              width: 50.px,
              decoration: BoxDecoration(
                  color: color.withOpacity(.1),
                  borderRadius: BorderRadius.circular(
                    10.px,
                  )),
              child: Center(
                child: CustomImageView(
                  imagePath: image,
                  height: 24.px,
                  width: 24.px,
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(height: 2.h),
          Text(title,
              style: AppTextStyle.pw500
                  .copyWith(color: textGrey, fontSize: 14.px)),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(count,
                  style: AppTextStyle.pw500
                      .copyWith(color: textGrey, fontSize: 20.px)),
              SizedBox(
                width: 1.w,
              ),
              Text(per,
                  style:
                      AppTextStyle.pw500.copyWith(color: red, fontSize: 12.px)),
              SizedBox(
                width: 1.w,
              ),
              Icon(
                Icons.show_chart,
                color: red,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Column(children: [
      CarouselSlider(
        carouselController: controller.carouselController,
        items: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 640.px, // Ensures it doesn't exceed height
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * .9,
              // height: 640.px,
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.px),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonSlider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  // buildSegmentedControl(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(child: buildBarChart(controller.barData))
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 500.px, // Ensures it doesn't exceed height
            ),
            child: Container(
              padding: EdgeInsets.all(2.h),
              margin: EdgeInsets.only(left: 3.w),
              width: MediaQuery.of(context).size.width * .9,
              // height: 640.px,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(10.px)),
              child: Column(
                children: [
                  commonSlider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  buildPieChart(controller.pieChartData)
                ],
              ),
            ),
          )
        ],
        options: CarouselOptions(
          height: 640.px,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              controller.sliderIndex.value = index;
              // _currentSlideIndex = index;
            });
          },
        ),
      ),
      SizedBox(height: 1.h),
      Obx(
        () => AnimatedSmoothIndicator(
          activeIndex: controller.sliderIndex.value,
          count: 2, // Number of items in the carousel
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: appColor,
            dotColor: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      SizedBox(height: 3.h),
    ]);
  }

  Widget commonSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Statistics",
          style: AppTextStyle.pw400.copyWith(color: textGrey, fontSize: 12.px),
        ),
        SizedBox(
          height: 1.h,
        ),
        Obx(
          () => Text(
            controller.sliderIndex.value == 0
                ? 'Brand Engagement'
                : "Publishing Overview",
            style: AppTextStyle.pw800.copyWith(
                color: black, fontSize: 14.px, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        buildSegmentedControl(),
      ],
    );
  }

  /// 📌 Pie Chart for Statistics
}

class StatsModel {
  String title;
  int count;
  String per;
  String? image;

  Color color;

  StatsModel({
    required this.title,
    required this.count,
    this.image,
    required this.per,
    required this.color,
  });
}

import 'package:brandiwave/Screen/home_screen/home_screen.dart';
import 'package:brandiwave/Screen/home_screen/widget/pie_chart_widget.dart';
import 'package:brandiwave/constants/image_constants.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  RxInt sliderIndex = 0.obs;
  RxInt selectedDurationIndex = 1.obs;
  List<BarChartModel> barData = [
    BarChartModel(label: "SHARE", value: 200, color: Color(0XFF962DFF)),
    BarChartModel(label: "COMMENTS", value: 1200, color: Color(0XFF4A3AFF)),
    BarChartModel(label: "LIKES", value: 1800, color: Color(0XFFE0C6FD)),
    BarChartModel(label: "VIEWS", value: 1000, color: Color(0XFF93AAFD)),
    BarChartModel(label: "ENGAGEMENT", value: 600, color: Color(0XFFA393FD)),
  ];
  List<PieChartModel> pieChartData = [
    PieChartModel(
        value: 40,
        titleV: '40',
        color: Color(0XFF962DFF),
        titleT: "Published Post"),
    PieChartModel(
        value: 30,
        titleV: '30',
        titleT: "Scheduled Post",
        color: Color(0XFF4A3AFF)),
    PieChartModel(
        value: 20,
        titleV: '20',
        titleT: "Rejected Post",
        color: Color(0XFFE0C6FD)),
    PieChartModel(
        value: 10,
        titleV: '10',
        titleT: "Approval Pending",
        color: Color(0XFF93AAFD)),
  ];

  RxList<StatsModel> statsList = [
    StatsModel(
      title: "Total \norganizations",
      count: 2500,
      per: "+25%",
      image: ImageConstant.oragnizationIcon,
      color: Color(0XFF54CEB6),
    ),
    StatsModel(
      title: "Total \nEmployees",
      count: 450,
      per: "+25%",
      image: ImageConstant.groupIcon,
      color: Color(0XFFFE196B),
    ),
    StatsModel(
      title: "Total \nPosts",
      count: 450,
      per: "+25%",
      image: ImageConstant.postIcon,
      color: appColor,
    ),
    StatsModel(
      title: "Total User \nEngagement",
      count: 450,
      per: "+25%",
      image: ImageConstant.engagementIcon,
      color: Color(0XFFF36643),
    ),
    StatsModel(
      title: "Total \nRevenue",
      count: 450,
      per: "+25%",
      image: ImageConstant.revenueIcon,
      color: Color(0XFFB524F8),
    ),
  ].obs;
}

class BarChartModel {
  final String label; // Label for the bar
  final double value; // Height of the bar
  final Color color; // Bar color

  BarChartModel(
      {required this.label, required this.value, required this.color});
}

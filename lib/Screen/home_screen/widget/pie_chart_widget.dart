import 'package:brandiwave/utils/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/custom_color.dart';

Widget buildPieChart(pieChartData) {
  return Column(
    children: [
      Container(
        height: 350,
        child: PieChart(
          PieChartData(
            sectionsSpace: 5,
            centerSpaceRadius: 80,
            sections: getSections(pieChartData),
          ),
        ),
      ),
      Column(
        children: [
          for (int index = 0; index < pieChartData.length; index++) ...[
            Container(
              padding: EdgeInsets.only(bottom: 1.h),
              width: 250.px,
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: pieChartData[index].color,
                    size: 20.px,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                      child: Text(
                    pieChartData[index].titleT,
                    style: AppTextStyle.pw600
                        .copyWith(fontSize: 14.px, color: black),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '- ${pieChartData[index].titleV}',
                    textAlign: TextAlign.end,
                    style: AppTextStyle.pw600
                        .copyWith(fontSize: 14.px, color: black),
                  ),
                ],
              ),
            )
          ]
        ],
      )
    ],
  );
}

List<PieChartSectionData> getSections(List<PieChartModel> data) {
  return data
      .map((item) => PieChartSectionData(
            titleStyle:
                AppTextStyle.pw800.copyWith(fontSize: 14.px, color: white),
            value: item.value,
            title: item.titleV,
            color: item.color,
            radius: 50,
          ))
      .toList();
}

class PieChartModel {
  final double value;
  final String titleV;
  final String titleT;
  final Color color;

  PieChartModel(
      {required this.value,
      required this.titleV,
      required this.titleT,
      required this.color});
}

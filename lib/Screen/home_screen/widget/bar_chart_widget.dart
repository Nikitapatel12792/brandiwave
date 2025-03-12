import 'dart:math';

import 'package:brandiwave/Screen/home_screen/controller/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/custom_color.dart';
import '../../../utils/custom_text.dart';

Widget buildBarChart(List<BarChartModel> data) {
  return SizedBox(
    height: 400.px, // Ensure it has proper height
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.map((e) => e.value).reduce((a, b) => a > b ? a : b) +
            200, // Dynamic max value
        barGroups: List.generate(data.length, (index) {
          return _buildBar(index, data[index].value, data[index].color);
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: customBottomTitles(
                data.map((e) => e.label).toList()), // Pass labels dynamically
          ),
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
      ),
    ),
  );
}

BarChartGroupData _buildBar(int x, double y, Color color) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: color,
        width: 40, // Bar width
        borderRadius: BorderRadius.circular(4),
      ),
    ],
  );
}

SideTitles customBottomTitles(List<String> labels) {
  return SideTitles(
    showTitles: true,
    reservedSize: 50, // Adjust spacing for better visibility
    getTitlesWidget: (double value, TitleMeta meta) {
      if (value.toInt() >= labels.length) {
        return const SizedBox(); // Prevent errors
      }
      return Padding(
        padding: const EdgeInsets.only(top: 5), // Uniform padding
        child: Transform.rotate(
          angle: pi * 0.5, // Rotate for readability
          child: SizedBox(
            width: 50, // Set a fixed width for proper alignment
            child: Center(
              child: Text(
                labels[value.toInt()], // Dynamically get label based on index
                textAlign: TextAlign.center,
                style: AppTextStyle.pw400.copyWith(
                  color: textGrey,
                  fontSize: 12.px,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

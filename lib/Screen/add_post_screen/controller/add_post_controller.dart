import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class AddPostController extends GetxController {
  RxString selectedAccount = "".obs;
  RxString selectShare = "".obs;
  RxString selectedTimeZone = "Asia/Kolkata".obs;
  RxString selectedQueue = "Queue in Next".obs;
  RxString selectedWorkFlow = "".obs;
  RxString selectedTag = "".obs;
  RxString selectedCampgian = "".obs;
  RxString selectedSection = "".obs;
  var dateTimeList = <String>[].obs; // Store multiple date-time selections
  var formattedDateTimeZone = "".obs;
  void toggleExpand(String title) {
    if (selectedSection.value == title) {
      selectedSection.value = ""; // Collapse if already expanded
    } else {
      selectedSection.value = title; // Expand the new section
    }
  }

  RxString dateRange = "".obs;

  RxList<String> schedulingList = [
    'Schedule',
    'Smart Scheduling',
    'Publishing Queue',
    'Save as draft',
    'Publish Now'
  ].obs;
  RxInt schedulIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    dateRange.value = '${DateFormat("MMM d, yyyy").format(DateTime.now())} - '
        '${DateFormat("MMM d, yyyy").format(DateTime.now().add(Duration(days: 7)))}';
    getFormattedDateTime();
    addNewDateTime();
  }

  void addNewDateTime() {
    String newDate = DateFormat("hh:mm a, d MMM yyyy | z")
        .format(DateTime.now()); // Example format
    dateTimeList.add(newDate);
  }

  TextEditingController contentController = TextEditingController();
  Future<void> getFormattedDateTime() async {
    // Initialize time zones
    tz.initializeTimeZones();

    // Fetch device's current time zone
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    print("User Time Zone: $currentTimeZone"); // Example: Asia/Kolkata
    // Get the location from the time zone name
    final location = tz.getLocation(currentTimeZone);
    // Get current time in the user's timezone
    final tzDateTime = tz.TZDateTime.from(DateTime.now(), location);
    // Format date & time
    String formattedTime =
        DateFormat('hh:mm a').format(tzDateTime); // Example: 03:29 PM
    String formattedDate =
        DateFormat('dd MMM yyyy').format(tzDateTime); // Example: 19 Feb 2025

    // Final output
    formattedDateTimeZone.value =
        "$formattedTime, $formattedDate  |  $currentTimeZone";
    print(formattedDateTimeZone.value);
  }

  void selectDateTime(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate =
          DateFormat("hh:mm a, d MMM yyyy | z").format(picked);
      dateTimeList.add(formattedDate);
    }
  }

  Future<void> selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
    );

    if (picked != null) {
      dateRange.value =
          '${DateFormat("MMM d, yyyy").format(picked.start)}- ${DateFormat("MMM d, yyyy").format(picked.end)}';
      print("Start Date: ${DateFormat("MMM d, yyyy").format(picked.start)}");
      print("End Date: ${picked.end}");
    }
  }
}

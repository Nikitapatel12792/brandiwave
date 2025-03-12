import 'package:brandiwave/Api/firebase_api.dart';
import 'package:brandiwave/Screen/home_container_screen/controller/home_container_controller.dart';
import 'package:brandiwave/widget/custom_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({super.key});

  @override
  State<HomeContainerScreen> createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  var homeContainerController = Get.put(HomeContainerController1());

// LocationPermission? permission;
//   Position? currentPosition;
  NotificationServices notificationServices = NotificationServices();
  String? address;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    FirebaseMessaging.instance.getToken().then((token) {
      print("Device Token: $token");
    });
    notificationServices.requestNotificationPermissions();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    // Put the BottomBarController here
    BottomNavigationController bottomBarController =
        Get.put(BottomNavigationController());

    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.red,
          body: Stack(
            children: [
              Positioned.fill(
                child: GetBuilder<BottomNavigationController>(
                  init: BottomNavigationController(),
                  builder: (controller) {
                    // Render the current view based on the selected tab
                    return controller.viewWidget;
                  },
                ),
              ),
              Positioned(
                  bottom: 20.0,
                  left: 0,
                  right: 0,
                  child: CustomBottomBar(
                    onChanged: (BottomMenuModel type) {
                      bottomBarController.onChange(type.widget);
                    },
                  ))
            ],
          ),
          // bottomNavigationBar: CustomBottomBar(
          //   onChanged: (BottomMenuModel type) {
          //     bottomBarController.onChange(type.widget);
          //   },
          // )
        ));
  }
}

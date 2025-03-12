import 'package:brandiwave/Screen/add_post_screen/add_post_screen.dart';
import 'package:brandiwave/Screen/home_screen/home_screen.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_color.dart';

// Bottom menu model
class BottomMenuModel {
  final IconData icon;
  final String label;
  final Widget widget;

  BottomMenuModel(
      {required this.icon, required this.label, required this.widget});
}

// Bottom navigation controller with GetX
class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs; // Observable index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Widget viewWidget = HomeScreen();
  onChange(Widget type) {
    print(type);
    viewWidget = type;
    update();
  }
}

class CustomBottomBar extends StatefulWidget {
  final Function(BottomMenuModel) onChanged;

  const CustomBottomBar({super.key, required this.onChanged});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    // Define the bottom menu items

    return Obx(
      () => Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 100,
            color: Colors.transparent,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CircleNavBar(
                // padding: EdgeInsets.only(bottom: 0.px),
                activeIndex: 2,
                activeIcons: [
                  Icon(Icons.home,
                      color: controller.selectedIndex.value == 0
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.email,
                      color: controller.selectedIndex.value == 1
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.add_circle,
                      size: 40,
                      color: controller.selectedIndex.value == 2
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.send,
                      color: controller.selectedIndex.value == 3
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.bar_chart,
                      color: controller.selectedIndex.value == 4
                          ? appColor
                          : bottomIcon),
                ],
                inactiveIcons: [
                  Icon(Icons.home,
                      color: controller.selectedIndex.value == 0
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.email,
                      color: controller.selectedIndex.value == 1
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.add_circle,
                      size: 40,
                      color: controller.selectedIndex.value == 2
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.send,
                      color: controller.selectedIndex.value == 3
                          ? appColor
                          : bottomIcon),
                  Icon(Icons.bar_chart,
                      color: controller.selectedIndex.value == 4
                          ? appColor
                          : bottomIcon),
                ],
                color: Colors.white,
                circleColor: appColor,
                height: 80,
                circleWidth: 60,
                cornerRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                shadowColor: Colors.black54,
                circleShadowColor: Colors.black54,
                elevation: 5,
                onTap: (val) {
                  print(val);
                  controller.changeIndex(val);
                  if (controller.selectedIndex.value == 0) {
                    controller.onChange(HomeScreen());
                  }
                  // if(controller.selectedIndex.value==1){
                  //   controller.onChange(OtpScreen());
                  // }
                  // if(controller.selectedIndex.value==3){
                  //   controller.onChange(MyActivityScreen());
                  // }
                  // if(controller.selectedIndex.value==4){
                  //   controller.onChange(CallScreen());
                  // }
                  if (controller.selectedIndex.value == 2) {
                    // controller.onChange(MyActivityScreen());
                  }
                }),
          ),
          GestureDetector(
            onTap: () {
              controller.onChange(AddPostScreen());
            },
            child: Container(
              height: 60,
              width: 60,
              decoration:
                  BoxDecoration(color: appColor, shape: BoxShape.circle),
              child: Icon(
                Icons.add_circle,
                color: white,
              ),
            ),
          )
        ],
      ),
    );
    //   Stack(
    //   alignment: Alignment.topCenter,
    //   children: [
    //     ClipPath(
    //       clipper: BottomNavBarClipper(),
    //       child: BottomAppBar(
    //        shape:  CircularNotchedAndCorneredRectangle(
    //           notchSmoothness: NotchSmoothness.defaultEdge,
    //           gapLocation: GapLocation.center,
    //           cornerRadius: 30.0, // Adjust corner radius as needed
    //         ),
    //         shadowColor: Colors.black54,
    //         color: Colors.white,
    //         child: Container(
    //           height: 60,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: <Widget>[
    //               IconButton(
    //                 icon: Icon(Icons.home),
    //                 onPressed: () {},
    //               ),
    //               IconButton(
    //                 icon: Icon(Icons.search),
    //                 onPressed: () {},
    //               ),
    //               SizedBox(width: 40), // Space for the floating action button
    //               IconButton(
    //                 icon: Icon(Icons.list),
    //                 onPressed: () {},
    //               ),
    //               IconButton(
    //                 icon: Icon(Icons.call),
    //                 onPressed: () {},
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(height: 60,width: 60,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,color: Color(0xffb514E61)
    //     ),
    //     child: Icon(Icons.add,color: white,),
    //     )
    //   ],
    // );

    //   BottomAppBar(
    //   color: white,
    //   shape: CircularNotchedRectangle(), // Optional for notch effect
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: List.generate(bottomMenuItems.length, (index) {
    //       // Leave space for cart icon in the middle
    //
    //
    //       return Obx(() {
    //         // Adjust selected index logic for non-cart items
    //         int adjustedIndex =  index;
    //         bool isSelected = controller.selectedIndex.value == index;
    //           print(isSelected);
    //        print( controller.selectedIndex.value);
    //         return GestureDetector(
    //           onTap: () {
    //             print(index);
    //             controller.selectedIndex.value = index;
    //             onChanged?.call(bottomMenuItems[index]);
    //
    //
    //           },
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //              Icon( bottomMenuItems[adjustedIndex].icon,
    //                  color: isSelected ? appColor : Colors.red
    //              ),
    //                SizedBox(height: 4),
    //               Text(
    //                 bottomMenuItems[adjustedIndex].label,
    //                 style: TextStyle(
    //                   fontSize: 12,
    //                     fontFamily: "poppins",
    //                     color: isSelected ? appColor :  Colors.red // Change text color
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       });
    //     }),
    //   ),
    // );
  }
}

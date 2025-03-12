import 'package:brandiwave/Screen/home_screen/home_screen.dart';
import 'package:brandiwave/Screen/post_screen/post_screen.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_bottom_bar.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onClose;

  const CustomDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.px, // Drawer width
      height: MediaQuery.of(context).size.height,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250.px, //
            child: DrawerHeader(
              decoration: BoxDecoration(color: appColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    height: 80.px,
                    width: 80.px,
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // Ensures the container is circular
                      border: Border.all(color: appColor, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(60.px), // Half of height/width
                      child: CustomImageView(
                        fit: BoxFit.cover,
                        url:
                            "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg",
                      ),
                    ),
                  )),
                  Text("Hello, Juan Gomez",
                      style: AppTextStyle.pw600
                          .copyWith(color: white, fontSize: 16.px)),
                  SizedBox(height: 1.h),
                  Text("juangomes@teqinvalley.in",
                      style: AppTextStyle.pw400
                          .copyWith(color: white, fontSize: 12.px)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("Home",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px)),
            onTap: () {
              final BottomNavigationController controller1 =
                  Get.put(BottomNavigationController());
              controller1.changeIndex(0);

              controller1.onChange(HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text("Post",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px)),
            onTap: () {
              final BottomNavigationController controller1 =
                  Get.put(BottomNavigationController());
              controller1.changeIndex(1);

              controller1.onChange(PostScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.public_sharp),
            title: Text("Publishing",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px)),
            onTap: () {
              final BottomNavigationController controller1 =
                  Get.put(BottomNavigationController());
              controller1.changeIndex(1);

              controller1.onChange(PostScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text("Message",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text("Setting",
                style:
                    AppTextStyle.pw400.copyWith(color: black, fontSize: 12.px)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text("Logout",
                style: AppTextStyle.pw400
                    .copyWith(color: Colors.red, fontSize: 12.px)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

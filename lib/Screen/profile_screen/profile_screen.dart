import 'package:brandiwave/Screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:brandiwave/Screen/new_password_screen/new_password_screen.dart';
import 'package:brandiwave/Screen/sign_in_screen/sign_in_screen.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/custom_bottom_bar.dart';
import 'package:brandiwave/widget/custom_image.dart';
import 'package:brandiwave/widget/show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.menu,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "My Profile",
                          style: AppTextStyle.pw600.copyWith(color: white),
                        )
                      ],
                    ),
                    Icon(
                      Icons.notifications_none_outlined,
                      color: white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Juan Gomez",
                              style: AppTextStyle.pw600.copyWith(color: white)),
                          Text("JuanGomez@teqinvelly.com",
                              style: AppTextStyle.pw400.copyWith(color: white))
                        ],
                      ),
                    ),
                    PopupMenuButton<int>(
                      color: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.px)),
                      onSelected: (value) {
                        if (value == 1) {
                          Get.to(() => EditProfileScreen());
                        } else if (value == 2) {
                          showCustomDialog(
                              desc: "Are you sure want to delete account?",
                              title: "Delete",
                              onNo: () {
                                Get.back();
                              },
                              onYes: () {
                                Get.back();
                              });
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 1, child: Text("Edit")),
                        PopupMenuDivider(),
                        PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: white,
                      ), // The button to open the menu
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.px),
                      topLeft: Radius.circular(30.px),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    commonWidget(
                        title: "Job Function", desc: "Product Management"),
                    SizedBox(
                      height: 3.h,
                    ),
                    commonWidget(title: "Job Level", desc: "Executive"),
                    SizedBox(
                      height: 3.h,
                    ),
                    commonWidget(title: "Language", desc: "English"),
                    SizedBox(
                      height: 3.h,
                    ),
                    commonWidget(title: "Password", desc: "******"),
                    SizedBox(
                      height: 3.h,
                    ),
                    commonWidget(title: "Signature", desc: ""),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          print("bb ");
                          await FirebaseAuth.instance.signOut();
                          print("User logged out successfully!");
                          Get.delete<BottomNavigationController>();
                          Get.to(
                              () => SignInScreen()); // Navigate to login screen
                        } catch (e) {
                          print("Logout Error: $e");
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 20.px,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "LogOut",
                            style: AppTextStyle.pw400
                                .copyWith(color: Colors.red, fontSize: 16.px),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Center(
                    child: Container(
                  height: 120.px,
                  width: 120.px,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Ensures the container is circular
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
                Container(
                  width: 30.px,
                  height: 30.px,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: appColor),
                  child: Icon(
                    Icons.edit,
                    color: white,
                    size: 20.px,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  commonWidget({required String title, desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.pw400
                  .copyWith(color: Colors.grey.shade600, fontSize: 16.px),
            ),
            title.contains("Password")
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => NewPasswordScreen());
                    },
                    child: Text(
                      "Change Password",
                      style: AppTextStyle.pw400
                          .copyWith(color: Colors.blueAccent, fontSize: 16.px),
                    ))
                : SizedBox()
          ],
        ),
        desc == ""
            ? SizedBox()
            : Text(
                desc,
                style:
                    AppTextStyle.pw600.copyWith(color: black, fontSize: 16.px),
              ),
        title.contains("Signature")
            ? Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "+Signature",
                        style: AppTextStyle.pw600.copyWith(
                            color: Colors.blueAccent, fontSize: 18.px),
                      )),
                ],
              )
            : SizedBox()
      ],
    );
  }
}

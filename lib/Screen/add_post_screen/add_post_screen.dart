import 'dart:developer';

import 'package:brandiwave/Screen/add_post_screen/controller/add_post_controller.dart';
import 'package:brandiwave/widget/custom_drop_down_widget.dart';
import 'package:brandiwave/widget/custom_elevated_button.dart';
import 'package:brandiwave/widget/custom_textfield2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:instagram_login/instagram_login.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:sizer/sizer.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../utils/custom_color.dart';
import '../../utils/custom_text.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var controller = Get.put(AddPostController());
  MultiSelectController controller1 = MultiSelectController();

  var items = [
    DropdownItem<String>(label: 'Item1', value: "1"),
    DropdownItem<String>(label: 'Item2', value: "2"),
    DropdownItem<String>(label: 'Item3', value: "3"),
    DropdownItem<String>(label: 'Item4', value: "4"),
    DropdownItem<String>(label: 'Item5', value: "5"),
    DropdownItem<String>(label: 'Item6', value: "6"),
    DropdownItem<String>(label: 'Item7', value: "7"),
    DropdownItem<String>(label: 'Item8', value: "8"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appColor,
        title: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: white,
              size: 20.px,
            ),
            Text(
              "My Post",
              style: AppTextStyle.pw600.copyWith(color: white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Accounts',
                style: AppTextStyle.pw400.copyWith(color: grey),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      message: "Please select the account",
                      icon: Icons.keyboard_arrow_down,
                      hintText: "Select account",
                      items: [
                        'Facebook Page',
                        'X',
                        'YouTube',
                        'Linked In',
                        'Instagram'
                      ],
                      selectedValue: controller.selectedAccount,
                    ),
                  ),
                  SizedBox(
                    width: 10.px,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.px)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 13),
                          side: BorderSide(color: appColor)),
                      onPressed: () async {
                        signInWithTwitter();

                        // instaLogin();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: appColor,
                          ),
                          Text(
                            "Add Account",
                            style: AppTextStyle.pw600.copyWith(
                              fontSize: 10.px,
                              color: appColor,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Content',
                style: AppTextStyle.pw400.copyWith(color: grey),
              ),
              SizedBox(height: 1.h),
              customTextField(
                  keyboard: TextInputType.multiline,
                  // Enables multi-line input
                  maxline: null,
                  obsecure: false,
                  child: SizedBox(
                    // padding: EdgeInsets.only(right: 5.w),
                    width: 60.px,
                    child: Row(
                      children: [
                        Icon(Icons.attach_file),
                        Icon(
                          Icons.ac_unit,
                          size: 20.px,
                        )
                      ],
                    ),
                  ),
                  controller: controller.contentController,
                  title: "",
                  hint: "Type your content here",
                  validator: (val) {}),
              SizedBox(height: 2.h),
              _buildSection(
                title: 'LinkedIn Profile Options',
                child: CustomDropdown(
                  items: ['option 1', 'option 2'],
                  selectedValue: controller.selectShare,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              _buildSection(
                title: 'Youtube Options',
                child: CustomDropdown(
                  items: ['option 1', 'option 2'],
                  selectedValue: controller.selectShare,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              _buildSection(
                title: 'Facebook Options',
                child: CustomDropdown(
                  items: ['option 1', 'option 2'],
                  selectedValue: controller.selectShare,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              _buildSection(
                  title: 'Publishing Properties', child: buildPublishWidget()),
              SizedBox(
                height: 2.h,
              ),
              _buildSection(
                  title: 'Scheduling Options',
                  child: _buildSchedulingOptions()),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      height: 45.px,
                      text: "Cancel",
                      textColor: black,
                      buttonColor: Colors.transparent,
                      buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.px))),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: Obx(
                      () => CustomElevatedButton(
                        height: 45.px,
                        text: controller.schedulIndex.value == 0
                            ? "Schedule"
                            : controller.schedulIndex.value == 1
                                ? "Schedule"
                                : controller.schedulIndex.value == 3
                                    ? "Save as Draft"
                                    : "Publish Now",
                        buttonColor: appColor,
                        textColor: white,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.px))),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.px),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  controller.toggleExpand(title);
                },
                child: Obx(() => Icon(controller.selectedSection.value == title
                    ? Icons.remove // Change icon when expanded
                    : Icons.add)),
              ),
            ],
          ),
          Obx(
            () => controller.selectedSection.value == title
                ? Column(
                    children: [
                      SizedBox(height: 1.h),
                      if (child != null) child,
                    ],
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }

  Widget _buildSchedulingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children:
                  List.generate(controller.schedulingList.length, (index) {
            return Obx(
              () => InkWell(
                onTap: () {
                  controller.schedulIndex.value = index;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 35.px,
                  margin: EdgeInsets.only(right: 2.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: controller.schedulIndex.value == index
                          ? Colors.grey.shade300
                          : white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.px)),
                  child: Text(
                    controller.schedulingList[index],
                    style: AppTextStyle.pw400.copyWith(color: black),
                  ),
                ),
              ),
            );
          })),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          if (controller.schedulIndex.value == 0) {
            return buildSchedule(); // Return widget when condition is met
          } else if (controller.schedulIndex.value == 1) {
            return buildSmartSchedule();
          } else if (controller.schedulIndex.value == 2) {
            return buildPublishingQueue();
          } else if (controller.schedulIndex.value == 3) {
            return buildSaveDraft();
          } else {
            return SizedBox();
          }
          // Return an empty widget when condition is not met
        }),
      ],
    );
  }

  Widget buildSaveDraft() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.px),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: Row(
        children: [
          Obx(() =>
              Expanded(child: Text(controller.formattedDateTimeZone.value))),
          InkWell(
              onTap: () {
                controller.selectDateTime(context);
              },
              child: const Icon(Icons.keyboard_arrow_down)),
        ],
      ),
    );
  }

  Widget buildPublishingQueue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Queue Preference"),
        SizedBox(
          height: 1.h,
        ),
        CustomDropdown(
            items: ['Queue in Next', 'Queue in Last'],
            selectedValue: controller.selectedQueue)
      ],
    );
  }

  Widget buildSmartSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date Range"),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(controller.dateRange.value)),
                    InkWell(
                        onTap: () {
                          controller.selectDateRange(context);
                        },
                        child: const Icon(Icons.keyboard_arrow_down)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(onTap: () {}, child: const Icon(Icons.add_circle)),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Text("Tome Zone"),
        SizedBox(
          height: 1.h,
        ),
        CustomDropdown(
            items: ["Asia/Kolkata", 'option 2'],
            selectedValue: controller.selectedTimeZone),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }

  Widget buildSchedule() {
    return Column(
      children: [
        _buildScheduledItem('LinkedIn'),
        _buildScheduledItem('Facebook'),
        SizedBox(height: 8),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Expanded(
                child: const Text(
                    'Choose Specific Date & Time for each Platform')),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduledItem(String platform) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$platform'),
        SizedBox(
          height: 1.h,
        ),
        Obx(() => Column(
              children: [
                ...controller.dateTimeList.map((dateTime) => Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(dateTime)), // Display date-time
                                InkWell(
                                  onTap: () {
                                    controller.selectDateTime(context);
                                  },
                                  child: const Icon(Icons.keyboard_arrow_down),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        InkWell(
                          onTap: () {
                            controller.addNewDateTime();
                          },
                          child: const Icon(Icons.add_circle),
                        ),
                      ],
                    ))
              ],
            )),
      ],
    );
  }

  Widget buildSmartScheduledItem(String platform) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$platform'),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    )),
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(() =>
                            Text(controller.formattedDateTimeZone.value))),
                    InkWell(
                        onTap: () {
                          controller.selectDateTime(context);
                        },
                        child: const Icon(Icons.keyboard_arrow_down)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(onTap: () {}, child: const Icon(Icons.add_circle)),
          ],
        ),
      ],
    );
  }

  Widget buildPublishWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Approval Workflow"),
        SizedBox(
          height: 1.h,
        ),
        CustomDropdown(
            items: ['option 1', 'option 2'],
            hintText: "Select Work Flow",
            selectedValue: controller.selectedWorkFlow),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tag"),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomDropdown(
                      items: ['option 1', 'option 2'],
                      hintText: "Select Tag",
                      selectedValue: controller.selectedTag)
                ],
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Campaign"),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomDropdown(
                      hintText: "Select Campaign",
                      items: ['option 1', 'option 2'],
                      selectedValue: controller.selectedCampgian),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  instaLogin() {
    {
      InstagramLogin.login(
        context,
        instaConfig: InstaConfig(
          instaUrl:
              'https://www.instagram.com/oauth/authorize?enable_fb_login=0&force_authentication=1&client_id=1144246780721682&redirect_uri=https://pub.dev/packages/instagram_login&response_type=code&scope=instagram_business_basic%2Cinstagram_business_manage_messages%2Cinstagram_business_manage_comments%2Cinstagram_business_content_publish%2Cinstagram_business_manage_insights',
          clientId: '1144246780721682',
          clientSecret: 'd14795c39353aef08c4ec1c442ced128',
        ),
        userData: (data) {
          print('User Data:');
          print('User ID: ${data.userId}');
          print('ID: ${data.id}');
          print('Name: ${data.name}');
          print('Username: ${data.username}');
          print('Account Type: ${data.accountType}');
          print('Followers Count: ${data.followersCount}');
          print('Follows Count: ${data.followsCount}');
          print('Media Count: ${data.mediaCount}');
          print('Profile Picture URL: ${data.profilePictureUrl}');
        },
      );
    }
  }

  void signInWithTwitter() async {
    final twitterLogin = new TwitterLogin(
        apiKey: 'daB7H8FJdk60kmamUMBi5kbgV',
        apiSecretKey: 'bFdvyfD0BA0jvQs3TnA92yDwWvHpIeqZlQLX3irJnvA56Uzyxn',
        redirectURI: 'flutter-twitter-practice://');

    // Trigger the sign-in flow
    await twitterLogin.login().then((value) async {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: value.authToken!,
        secret: value.authTokenSecret!,
      );
      print(twitterAuthCredential);
      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    });
  }

  facebookLogin() async {
    print("nhn");
    // Perform Facebook login and retrieve user data
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);
      print('bvhfbvhffvbh${result.message}');

      // Check if login was successful
      if (result.status == LoginStatus.success) {
        FacebookAuth.instance.getUserData().then((value) async {
          log('Facebook data = ${value.toString()}');

          // Retrieve profile picture URL
          String profilePic = value['picture']['data']['url'] ??
              'https://scontent.fccu13-4.fna.fbcdn.net/v/t1.30497-1/84628273_176159830277856_972693363922829312_n.jpg?stp=dst-jpg_s200x200&_nc_cat=1&ccb=1-7&_nc_sid=12b3be&_nc_ohc=MuO79r3PEPEAX_0gqiY&_nc_ht=scontent.fccu13-4.fna&edm=AP4hL3IEAAAA&oh=00_AfBOK-hKzJKQCkhsKCyM_YhVhPvnzHunFi5cLY0xvvqflA&oe=64941199';
        });
      }
    } catch (e) {
      print("fef");
      print(e);
      Fluttertoast.showToast(
          msg: "Login Failed",
          fontSize: 14,
          backgroundColor: appColor,
          textColor: white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
      // FacebookAuth.instance.logOut();
    }
  }
}

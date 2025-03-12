import 'package:brandiwave/Screen/add_post_screen/add_post_screen.dart';
import 'package:brandiwave/Screen/post_screen/controller/post_list_controller.dart';
import 'package:brandiwave/utils/custom_color.dart';
import 'package:brandiwave/utils/custom_text.dart';
import 'package:brandiwave/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../widget/custom_floating_button.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var controller = Get.put(PostListController());
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
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(blurRadius: 4.0, color: Colors.black54)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getPlatformIcon(
                                post.platform), // Icon based on platform
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        post.content,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.edit,
                                              color: appColor,
                                              size: 20.px,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showCustomDialog(
                                                  title: "Delete",
                                                  onNo: () {
                                                    Get.back();
                                                  },
                                                  onYes: () {
                                                    Get.back();
                                                  },
                                                  desc:
                                                      "Are you sure want to delete this post?");
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: black,
                                              size: 20.px,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${post.platform} • ${post.dateTime}",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: customFloatinfButton(
        icon: Icons.add_circle,
        title: "Add Post",
        ontap: () {
          Get.to(() => AddPostScreen());
        },
      ),
    );
  }

  Widget _getPlatformIcon(String platform) {
    IconData icon;
    Color color;

    switch (platform.toLowerCase()) {
      case "linkedin":
        icon = Icons.business;
        color = Colors.blue;
        break;
      case "facebook":
        icon = Icons.facebook;
        color = Colors.blueAccent;
        break;
      case "twitter":
        icon = Icons.chat;
        color = Colors.lightBlue;
        break;
      default:
        icon = Icons.public;
        color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    );
  }
}

class Post {
  final String content;
  final String platform;
  final String dateTime;

  Post({required this.content, required this.platform, required this.dateTime});
}

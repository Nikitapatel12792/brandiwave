import 'package:brandiwave/Screen/post_screen/post_screen.dart';
import 'package:get/get.dart';

class PostListController extends GetxController {
  var posts = <Post>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadDummyPosts(); // Load dummy data on startup
  }

  void loadDummyPosts() {
    posts.assignAll([
      Post(
          content: "Launching our new product! 🚀",
          platform: "LinkedIn",
          dateTime: "03:29 PM, 19 Feb 2025 | Asia/Kolkata"),
      Post(
          content: "Launching our new product! 🚀",
          platform: "LinkedIn",
          dateTime: "03:29 PM, 19 Feb 2025 | Asia/Kolkata"),
      Post(
          content: "Launching our new product! 🚀",
          platform: "LinkedIn",
          dateTime: "03:29 PM, 19 Feb 2025 | Asia/Kolkata"),
      Post(
          content: "Join our live Q&A session! 🎙️",
          platform: "Facebook",
          dateTime: "04:00 PM, 20 Feb 2025 | Asia/Kolkata"),
      Post(
          content: "Exciting news coming soon! 🎉",
          platform: "Twitter",
          dateTime: "12:45 PM, 21 Feb 2025 | Asia/Kolkata"),
    ]);
  }
}

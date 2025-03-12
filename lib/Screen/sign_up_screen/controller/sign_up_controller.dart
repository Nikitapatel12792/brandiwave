// import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class SignUpController extends GetxController {
  RxString fullName = "".obs;
  TextEditingController email = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  /// without firebase
  Future<void> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'], // You can add 'profile' if needed
    );

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('User canceled the login');
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User Email: ${googleUser.email}");
      print("Access Token: ${googleAuth.accessToken}");
      print("ID Token: ${googleAuth.idToken}");
    } catch (error) {
      print("Error signing in: $error");
    }
  }

  /// login with firebase
  // Future<Map<String, dynamic>?> googleSignIn() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'email',
  //         'profile', // ✅ Google Calendar Access
  //       ],
  //     );
  //
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //
  //     if (googleUser == null) {
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     // String? accessToken = googleAuth?.accessToken;
  //     // if (accessToken != null) {
  //     //   await createGoogleCalendarEvent(accessToken);
  //     // }
  //
  //     // Sign in with Firebase
  //     UserCredential authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     User? user = authResult.user;
  //
  //     if (user != null) {
  //       fullName.value = user.displayName ?? "";
  //       Get.to(() => SGetStartedScreen());
  //       // name.value="Radhika";
  //       // email.value="radhikajogi85@gmail.com";
  //       // googleId.value="107150953596651430487";
  //       // SignIn();
  //       // Return User Data
  //     }
  //   } catch (e) {}
  //   return null;
  // }
  /// without firebase
  Future<void> signIn() async {
    final Config config = Config(
      tenant: "common", // Set this to "common" for multi-tenant apps
      clientId: "90e27eb8-f864-4893-bb43-493f7b5b28f9",
      scope: "openid profile email User.Read offline_access",
      redirectUri: kIsWeb
          ? "your local host URL"
          : "msauth://com.app.brandiwave.brandiwave/6%2B%2FRMe5V5vx8ZCEMUhnOq8t8QUY%3D",
      navigatorKey:
          navigatorKey, // Ensure this key is defined in your main file under MaterialApp.
    );
    final AadOAuth oauth = AadOAuth(config);
    final result = await oauth.login();
    print(result);
    result.fold((l) => print("Microsoft Authentication Failed!"), (r) async {
      print("Login Successful!");
      print("Access Token: ${r.accessToken}");
      final userDetails = await fetchAzureUserDetails(r.accessToken.toString());
    });
  }

  Future<void> fetchAzureUserDetails(String accessToken) async {
    final response = await http.get(
      Uri.parse("https://graph.microsoft.com/v1.0/me"),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );
    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      print("User Data: ${response.body}");
    } else {
      print("Failed to fetch user details: ${response.body}");
    }
  }

  /// with firebase
// Future<void> loginWithMicrosoft() async {
//   final microsoftProvider = MicrosoftAuthProvider();
//
//   try {
//     UserCredential userCredential;
//
//     if (kIsWeb) {
//       // Use signInWithPopup for web
//       userCredential =
//           await FirebaseAuth.instance.signInWithPopup(microsoftProvider);
//     } else {
//       // Use signInWithProvider for mobile
//       userCredential =
//           await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
//     }
//
//     User? user = userCredential.user;
//
//     if (user != null) {
//       print(
//           "Login successful! User: ${user.displayName}, Email: ${user.email}");
//       Get.to(() => HomeContainerScreen());
//       // Get.offAllNamed('/home'); // Change to your home route
//     } else {
//       // ❌ Login Failed
//       print("Login failed! User is null.");
//     }
//   } catch (e) {
//     // ❌ Handle errors
//     print("Login Error: $e");
//   }
// }
}

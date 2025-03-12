import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Get the device token
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  /// Request notification permissions
  void requestNotificationPermissions() async {
    if (Platform.isIOS) {
      await messaging.requestPermission();
    }

    NotificationSettings notificationSettings =
        await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('User granted permissions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permissions');
    } else {
      print('User denied permissions');
    }
  }

  /// For iOS: Configure foreground notification behavior
  Future<void> foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Initialize Firebase messaging and set up listeners
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print("Notification title: ${notification?.title}");
      print("Notification body: ${notification?.body}");
      print("Data: ${message.data}");

      if (Platform.isIOS) {
        foregroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
        // showBigPictureNotificationURL(message);
      }
    });
  }

  /// Initialize local notifications
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  /// Handle message based on payload
  void handleMessage(BuildContext context, RemoteMessage message) {
    // Implement navigation or actions based on the message payload
    print("Handle message data: ${message.data}");
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("easyapproach", "easyapproach channel",
            channelDescription: "This is our channel",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: androidNotificationChannel.sound);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  /// Setup interactions for background and terminated states
  Future<void> setupInteractMessage(BuildContext context) async {
    // Handle app termination case
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    // Handle app background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("Message opened: ${event.data}");
      handleMessage(context, event);
    });
  }
}

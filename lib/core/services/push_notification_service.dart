import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../route/route_helper.dart';
import 'local_notification_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future initialize() async {
    if (Platform.isIOS) {
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(LocalNotificationService.channel);
    }

    await getToken();

    _fcm.getInitialMessage().then((RemoteMessage? value) {
      if (value != null) onAppOpen(value);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(onAppOpen);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleRemoteMessage(message);
    });
  }

  void handleRemoteMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      final notifyModel = LocalNotificationModel(
          id: message.messageId.hashCode,
          body: notification.body,
          title: notification.title ?? "");
      LocalNotificationService.showNotification(
        notifyModel,
        onClick: (dynamic payload) {
          onAppOpen(message);
        },
      );
    }
  }

  void onAppOpen(RemoteMessage message) {
    Get.toNamed(RouteHelper
        .getDashboardToNotificationRoute());
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification != null) {
    final notifyModel = LocalNotificationModel(
        id: message.messageId.hashCode,
        body: notification.body,
        title: notification.title ?? "");
    LocalNotificationService.showNotification(
      notifyModel,
      onClick: (dynamic payload) {
        Get.toNamed(RouteHelper
            .getDashboardToNotificationRoute());
      },
    );
  }
}
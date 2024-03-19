import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';

import '../route/route_helper.dart';
import 'local_notification_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future initialize(NotificationRepository notificationRepository) async {
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
      saveNotificationFirestore(message, notificationRepository);
      handleRemoteMessage(message);
    });
  }
  
  void saveNotificationFirestore(RemoteMessage message, NotificationRepository notificationRepository) {
    final notificationModel = NotificationModel(
        id: message.messageId!,
        title: message.notification?.title ?? "",
        content: message.notification?.body ?? "",
        created: message.data["created"],
        location: message.data["location"]
    );
    notificationRepository.addOrUpdateNotification(userId: FirebaseAuth.instance.currentUser!.uid, notification: notificationModel);
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
    print('Token: $token');
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
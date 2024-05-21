import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../route/route_helper.dart';

class LocalNotificationService {
  static AndroidNotificationChannel get channel => const AndroidNotificationChannel(
    'com.satesocial.sate_social',
    'sate_social',
    description: 'sate_social_description',
    playSound: true,
    enableVibration: false,
    importance: Importance.max,
    showBadge: true,
    enableLights: true,
  );

  static AndroidNotificationDetails get androidNotificationDetails =>
      AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'launch_background',
        playSound: channel.playSound,
        channelShowBadge: true,
        enableVibration: channel.enableVibration,
        importance: channel.importance,
        priority: Priority.high,
        enableLights: channel.enableVibration,
      );

  static DarwinNotificationDetails get iosNotificationDetails =>
      const DarwinNotificationDetails(
        presentBadge: true,
        presentSound: true,
        presentAlert: true,
      );

  static void showNotification(LocalNotificationModel notification,
      String chatId) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        Get.toNamed(RouteHelper
            .getOpenChatRoute(chatId));
      },
      onDidReceiveBackgroundNotificationResponse: null
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      notification.id,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: json.encode(notification.toJson()),
    );
  }
}

class LocalNotificationModel {
  int id;
  String title;
  String? body;

  LocalNotificationModel({
    required this.id,
    required this.title,
    this.body,
  });

  factory LocalNotificationModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'] ?? 0;
    String title = json['title'] ?? "";
    String body = json['body'] ?? "";

    return LocalNotificationModel(
        id: id,
        title: title,
        body: body,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }


  static String encodeListToString(List<LocalNotificationModel> notifications) {
    return jsonEncode(notifications.map((i) => i.toJson()).toList()).toString();
  }

  static List<LocalNotificationModel> decodeToList(String jsonNotifications) =>
      jsonDecode(jsonNotifications).map<LocalNotificationModel>((item) => LocalNotificationModel.fromJson(item))
          .toList();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LocalNotificationModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

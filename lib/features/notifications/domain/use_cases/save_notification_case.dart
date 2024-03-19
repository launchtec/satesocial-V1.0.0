import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../repositories/notification_repository.dart';

class SaveNotificationCase {
  final NotificationRepository notificationRepository;

  SaveNotificationCase({required this.notificationRepository});

  Future<void> call(String userId, NotificationModel notification) async {
    try {
      await notificationRepository.addOrUpdateNotification(userId: userId, notification: notification);
    } catch (error) {
      throw Exception(error);
    }
  }
}
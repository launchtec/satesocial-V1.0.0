import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../repositories/notification_repository.dart';

class GetNotificationsCase {
  final NotificationRepository notificationRepository;

  GetNotificationsCase({required this.notificationRepository});

  Stream<Iterable<NotificationModel>> call(String userId) {
    return notificationRepository.getStreamNotifications(
      userId: userId,
    );
  }
}
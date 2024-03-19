import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../repositories/notification_repository.dart';

class NotificationsUseCase {
  final NotificationRepository notificationRepository;

  NotificationsUseCase({required this.notificationRepository});

  Stream<Iterable<NotificationModel>> call(String userId) {
    return notificationRepository.getStreamNotifications(
      userId: userId,
    );
  }
}
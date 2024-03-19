import 'package:equatable/equatable.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';

class NotificationsState extends Equatable {
  final bool isLoading;
  final Iterable<NotificationModel> notificationModels;

  const NotificationsState({
    this.isLoading = true,
    this.notificationModels = const [],
  });

  @override
  List<Object?> get props => [isLoading, notificationModels];
}
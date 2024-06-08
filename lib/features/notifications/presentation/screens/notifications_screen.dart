import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';
import 'package:sate_social/features/notifications/domain/use_cases/get_notifications_case.dart';
import 'package:sate_social/features/notifications/domain/use_cases/read_notification_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/get_notifications/notifications_state.dart';
import 'package:sate_social/features/notifications/presentation/blocks/read_notification/read_notification_cubit.dart';
import 'package:sate_social/features/notifications/presentation/blocks/read_notification/read_notification_state.dart';
import 'package:sate_social/features/notifications/presentation/widgets/notification_item_widget.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../auth/presentation/blocks/update_activity/update_activity_cubit.dart';
import '../../data/models/notification_model.dart';
import '../blocks/get_notifications/notifications_cubit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    context.read<UpdateActivityCubit>().updateActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backNotification),
                  fit: BoxFit.cover),
            ),
            child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => NotificationsCubit(
                            notificationsUseCase: GetNotificationsCase(
                                notificationRepository:
                                    context.read<NotificationRepository>()),
                          )..init()),
                  BlocProvider(
                      create: (context) => ReadNotificationCubit(
                            readNotificationCase: ReadNotificationCase(
                                notificationRepository:
                                    context.read<NotificationRepository>()),
                          ))
                ],
                child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                  notifications = state.notificationModels.toList();
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('MY NOTIFICATIONS',
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeOverLarge,
                                      shadows: const [
                                        Shadow(
                                          color: Colors
                                              .black, // Choose the color of the shadow
                                          blurRadius:
                                              2.0, // Adjust the blur radius for the shadow effect
                                          offset: Offset(-1.0,
                                              1.0), // Set the horizontal and vertical offset for the shadow
                                        ),
                                      ],
                                      color: Colors.black))
                            ]),
                        const Divider(color: Colors.grey, thickness: 5),
                        Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeSmall),
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return BlocConsumer<ReadNotificationCubit, ReadNotificationState>(
                                  listener: (context, state) {
                                    if (state.requestStatus == RequestStatus.submissionFailure) {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'There was an error with the sign in process. Try again.',
                                            ),
                                          ),
                                        );
                                    }
                                    if (state.requestStatus == RequestStatus.submissionSuccess) {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'The notification was successfully read',
                                            ),
                                          ),
                                        );
                                    }
                                  }, builder: (context, state) {
                                    return InkWell(
                                        child: NotificationItemWidget(
                                            notificationModel:
                                            notifications[index],
                                            isLastItem: index ==
                                                notifications.length - 1),
                                        onTap: () {
                                          if (!notifications[index].isOpen) {
                                            context
                                                .read<ReadNotificationCubit>()
                                                .readNotification(
                                                notifications[index]);
                                          }
                                          Get.toNamed(RouteHelper
                                              .getOpenChatRoute(notifications[index].chatId!));
                                        });
                                  });
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                })),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                      ]);
                }))));
  }
}

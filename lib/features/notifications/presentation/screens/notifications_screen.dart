import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';
import 'package:sate_social/features/notifications/domain/use_cases/get_notifications_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/notifications_state.dart';
import 'package:sate_social/features/notifications/presentation/widgets/notification_item_widget.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../data/models/notification_model.dart';
import '../blocks/notifications_cubit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
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
            child: BlocProvider(
                create: (context) => NotificationsCubit(
                    notificationsUseCase: GetNotificationsCase(
                        notificationRepository:
                            context.read<NotificationRepository>()))
                  ..init(FirebaseAuth.instance.currentUser!.uid),
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
                                  return InkWell(
                                      child: NotificationItemWidget(
                                          notificationModel:
                                              notifications[index],
                                          isLastItem: index ==
                                              notifications.length - 1),
                                      onTap: () {
                                        if (!notifications[index].isOpen) {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'The notification was successfully read',
                                                ),
                                              ),
                                            );
                                          setState(() {
                                            notifications[index].isOpen = true;
                                          });
                                        }
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

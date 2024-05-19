import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat/add_chat_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat/add_chat_state.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';
import 'package:sate_social/features/notifications/domain/use_cases/add_notification_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/add_notification/add_notification_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../messages/data/models/chat.dart';

class PostInfoDialog extends StatelessWidget {
  final PostModel post;
  final Chat? chat;

  const PostInfoDialog({super.key, required this.post, this.chat});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddChatCubit(
                      addChatCase: AddChatCase(
                    chatRepository: context.read<ChatRepository>(),
                  ))),
          BlocProvider(
              create: (context) => AddNotificationCubit(
                  addNotificationCase: AddNotificationCase(
                    notificationRepository: context.read<NotificationRepository>(),
                  ))),
        ],
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: TextStyle(
              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
          content: BlocBuilder<AddChatCubit, AddChatState>(
              builder: (context, state) {
            return SizedBox(
                width: double.maxFinite,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Stack(children: [
                    Container(
                        width: double.maxFinite,
                        color: ColorConstants.darkGrey,
                        child: Column(children: [
                          Image.asset(post.imageCircleCategory(), height: 100),
                          Text(post.category,
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: const [
                                    Shadow(
                                      color: Colors
                                          .black, // Choose the color of the shadow
                                      blurRadius:
                                          4.0, // Adjust the blur radius for the shadow effect
                                      offset: Offset(0,
                                          4.0), // Set the horizontal and vertical offset for the shadow
                                    ),
                                  ],
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.radiusExtraLarge))),
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.fontSizeOverSmall),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.fontSizeOverSmall,
                                  vertical: Dimensions.fontSizeOverSmall),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      const Icon(Icons.location_on, size: 12),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeMinimal),
                                      Text('Zip Code: ${post.zipCode}',
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeOverSmall))
                                    ]),
                                    Row(children: [
                                      const Icon(Icons.access_time_rounded,
                                          size: 12),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeMinimal),
                                      Text(
                                          timeago.format(
                                              DateTime.parse(post.created)),
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeOverSmall))
                                    ]),
                                    Row(children: [
                                      Image.asset(Images.vectorIcon,
                                          height: 12),
                                      Text('Featured Listing',
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeOverSmall))
                                    ])
                                  ])),
                          const SizedBox(height: Dimensions.paddingSizeSmall)
                        ])),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white60, size: 28),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ]),
                  ]),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault),
                      color: ColorConstants.dialogBackground,
                      child: Column(children: [
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault),
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeOverLarge),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.white,
                            )),
                            child: Center(
                                child: Text(post.title,
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)))),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        const Divider(thickness: 0.5),
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault),
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeOverLarge),
                            child: Center(
                                child: Text('Description: ${post.content}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Colors.white)))),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (chat == null) {
                                    await context
                                        .read<AddChatCubit>()
                                        .addChat(post);
                                    Navigator.pop(context);
                                    Get.toNamed(
                                        RouteHelper.getCommunityChatsRoute());
                                  } else {
                                    Navigator.pop(context);
                                    Get.toNamed(
                                        RouteHelper.getOpenChatRoute(chat!.id));
                                  }
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeMiddleSmall)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.primaryColor)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          chat == null
                                              ? 'Send Response'
                                              : 'Open Response',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Image.asset(Images.message, height: 24)
                                    ])))
                      ])),
                ]));
          }),
          actions: null,
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_message_case.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_chat_case.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_messages_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_message/add_message_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chat/get_chat_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_messages/get_messages_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_messages/get_messages_state.dart';
import 'package:sate_social/features/messages/presentation/widgets/message_item_widget.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';
import 'package:sate_social/features/notifications/domain/use_cases/add_notification_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/add_notification/add_notification_cubit.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../blocks/get_chat/get_chat_state.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => GetChatCubit(
                  getChatCase: GetChatCase(
                chatRepository: context.read<ChatRepository>(),
              ))),
      BlocProvider(
          create: (context) => GetMessagesCubit(
                  getMessagesCase: GetMessagesCase(
                chatRepository: context.read<ChatRepository>(),
              ))
                ..init(chatId)),
      BlocProvider(
          create: (context) => AddMessageCubit(
                  addMessageCase: AddMessageCase(
                chatRepository: context.read<ChatRepository>(),
              ))),
      BlocProvider(
          create: (context) => AddNotificationCubit(
                  addNotificationCase: AddNotificationCase(
                notificationRepository: context.read<NotificationRepository>(),
              )))
    ], child: ChatView(chatId: chatId));
  }
}

class ChatView extends StatefulWidget {
  final String chatId;
  const ChatView({super.key, required this.chatId});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _inputMessageController = TextEditingController();
  String city = '';

  @override
  void initState() {
    try {
      city = Get.find<String>(tag: 'city');
    } catch (exception) {}
    context.read<GetChatCubit>().getChat(widget.chatId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child: BlocBuilder<GetChatCubit, GetChatState>(
                builder: (blocContext, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.grey)),
                            Image.asset(Images.logo, height: 65),
                          ]),
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeExtraLarge),
                              child: Text(city,
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeTitle,
                                      shadows: const [
                                        Shadow(
                                          color: Colors
                                              .black, // Choose the color of the shadow
                                          blurRadius:
                                              2.0, // Adjust the blur radius for the shadow effect
                                          offset: Offset(-4.0,
                                              1.0), // Set the horizontal and vertical offset for the shadow
                                        ),
                                      ],
                                      color: ColorConstants.secondColor)))
                        ]),
                    const Divider(color: Colors.grey, thickness: 5),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Center(
                        child: Column(children: [
                      Text('Viewing Responses For:',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.fontSizeExtraLarge)),
                      Text(state.chat!.postInfo?.title ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: Dimensions.fontSizeLarge)),
                    ])),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Expanded(
                        child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeDefault),
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorConstants.secondColor,
                                  ColorConstants.cardAlertColor
                                ],
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radiusLarge)),
                            ),
                            child: Stack(children: [
                              Column(children: [
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                Text(
                                    '${state.chat!.receiver?.name ?? ''}\'s Response',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge)),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                Image.asset(Images.avatar, height: 64),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                Text('Active 5 minutes ago',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                                const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall),
                                IntrinsicHeight(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text('${state.chat!.receiver?.age ?? ''}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.fontSizeDefault)),
                                      const VerticalDivider(
                                          thickness: 2, color: Colors.white),
                                      Text(state.chat!.receiver?.gender ?? '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.fontSizeDefault)),
                                      const VerticalDivider(
                                          thickness: 2, color: Colors.white),
                                      Text(state.chat!.receiver?.height ?? '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.fontSizeDefault)),
                                    ])),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                const Divider(
                                    thickness: 4, color: Colors.white),
                                Expanded(child: BlocBuilder<GetMessagesCubit,
                                        GetMessagesState>(
                                    builder: (blocContext, state) {
                                  final messages = state.messages.toList().reversed.toList();
                                  return !state.isLoading
                                      ? ListView.builder(
                                          reverse: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall,
                                              horizontal: Dimensions
                                                  .paddingSizeExtraSmall),
                                          itemCount: messages.length,
                                          itemBuilder: (context, index) {
                                            return MessageItemWidget(
                                                message: messages[index],
                                                ownerId: FirebaseAuth
                                                    .instance.currentUser!.uid);
                                          })
                                      : const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.0));
                                })),
                                const SizedBox(
                                    height: Dimensions.paddingSizeOverLarge),
                              ]),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    child: TextField(
                                      controller: _inputMessageController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusOverLarge),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: Dimensions
                                                      .paddingSizeDefault,
                                                  vertical: 0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Input text here',
                                          suffixIcon: IconButton(
                                              icon: Image.asset(Images.sending,
                                                  height: 32),
                                              onPressed: () async {
                                                await context
                                                    .read<AddMessageCubit>()
                                                    .addMessage(
                                                        state.chat!.id,
                                                        _inputMessageController
                                                            .text);
                                                await context
                                                    .read<
                                                        AddNotificationCubit>()
                                                    .addNotification(
                                                        FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid ==
                                                                state.chat!
                                                                    .senderId
                                                            ? state.chat!
                                                                .sender!.name
                                                            : state.chat!
                                                                .receiver!.name,
                                                        _inputMessageController
                                                            .text,
                                                        FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid !=
                                                                state.chat!
                                                                    .senderId
                                                            ? state
                                                                .chat!.senderId
                                                            : state.chat!
                                                                .receiverId, widget.chatId);
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                setState(() {
                                                  _inputMessageController.text =
                                                      '';
                                                });
                                              })),
                                    ),
                                  ))
                            ]))),
                    const SizedBox(height: Dimensions.paddingSizeOverLarge),
                  ]);
            })));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_chats_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chats/get_chats_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chats/get_chats_state.dart';
import 'package:sate_social/features/messages/presentation/widgets/chat_item_widget.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class PostChatScreen extends StatelessWidget {
  const PostChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetChatsCubit(
                getChatsCase: GetChatsCase(
              chatRepository: context.read<ChatRepository>(),
            ))
              ..init(FirebaseAuth.instance.currentUser!.uid, true),
        child: const PostChatsView());
  }
}

class PostChatsView extends StatefulWidget {
  const PostChatsView({super.key});

  @override
  State<PostChatsView> createState() => _PostChatsViewState();
}

class _PostChatsViewState extends State<PostChatsView> {
  String city = '';

  @override
  void initState() {
    try {
      city = Get.find<String>(tag: 'city');
    } catch (exception) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.grey)),
                  Image.asset(Images.logo, height: 65),
                ]),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text(Get.find<String>(tag: 'city') ?? '',
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
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Center(
                  child: Text('Your Community Messages',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeOverLarge))),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Expanded(child: BlocBuilder<GetChatsCubit, GetChatsState>(
                  builder: (blocContext, state) {
                final chats = state.chats.toList();
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radiusLarge)),
                  ),
                  child: !state.isLoading
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall,
                              horizontal: Dimensions.paddingSizeExtraSmall),
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return ChatItemWidget(
                                chat: chats[index], onTap: () => Get.toNamed(RouteHelper.getOpenChatRoute(chats[index])));
                          })
                      : const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.0)),
                );
              })),
              const SizedBox(height: Dimensions.paddingSizeOverLarge),
            ])));
  }
}

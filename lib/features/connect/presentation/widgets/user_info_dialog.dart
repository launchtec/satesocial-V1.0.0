import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat/add_chat_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat/add_chat_state.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat_connect/add_chat_connect_state.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../messages/presentation/blocks/add_chat_connect/add_chat_connect_cubit.dart';

class UserInfoDialog extends StatelessWidget {
  final AppUser user;

  const UserInfoDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddChatConnectCubit(
              addChatCase: AddChatCase(
                chatRepository: context.read<ChatRepository>(),
              ),
            ),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: TextStyle(
              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
          content: BlocBuilder<AddChatConnectCubit, AddChatConnectState>(
              builder: (context, state) {
            return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                ),
                child: Stack(children: [
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorConstants.blueBack1,
                              ColorConstants.blueBack2,
                              ColorConstants.blueBack3,
                              ColorConstants.blueBack4,
                            ],
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radiusLarge),
                              topLeft: Radius.circular(Dimensions.radiusLarge)),
                        ),
                        child: Column(children: [
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Image.asset(Images.avatar, height: 64),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text('Active 5 minutes ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeExtraLarge)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          IntrinsicHeight(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text('${user.age ?? ''}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                                const VerticalDivider(
                                    thickness: 2, color: Colors.white),
                                Text(user.gender ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                                const VerticalDivider(
                                    thickness: 2, color: Colors.white),
                                Text(user.height ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                              ])),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.ethnicity ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.sexuality,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text('Interested in: Friends',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeLarge)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtremeLarge),
                        ])),
                    Container(
                        width: double.infinity,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: ColorConstants.greyBack,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(Dimensions.radiusLarge),
                              bottomRight:
                                  Radius.circular(Dimensions.radiusLarge)),
                        ))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white60, size: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]),
                  Positioned(
                      bottom: 80,
                      left: 0,
                      right: 0,
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                await context.read<AddChatConnectCubit>().addChat(user);
                                Navigator.pop(context);
                                Get.toNamed(RouteHelper.getConnectChatsRoute());
                              },
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(Images.sending,
                                        height: 24,
                                        color: ColorConstants.sendPingColor),
                                    const Text('SEND PING',
                                        style: TextStyle(
                                            color: ColorConstants.sendPingColor,
                                            fontWeight: FontWeight.bold))
                                  ])))),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Image.asset(Images.instagramConnect, height: 48),
                          Text('@YourUsername',
                              style: TextStyle(
                                  color: ColorConstants.textInstaColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeDefault)),
                        ])),
                  ),
                ]));
          }),
          actions: null,
        ));
  }
}

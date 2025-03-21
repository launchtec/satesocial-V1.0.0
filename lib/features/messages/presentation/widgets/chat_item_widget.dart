import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../auth/data/models/app_user.dart';

class ChatItemWidget extends StatelessWidget {
  final Chat chat;
  final Function onTap;

  const ChatItemWidget({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeMinimal,
            horizontal: Dimensions.paddingSizeMinimal),
        child: InkWell(
            onTap: () => onTap(),
            child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                    vertical: Dimensions.paddingSizeMinimal),
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeMinimal,
                    horizontal: Dimensions.paddingSizeDefault),
                decoration: const BoxDecoration(
                  color: ColorConstants.secondColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radiusExtraLarge)),
                ),
                child: IntrinsicHeight(
                    child: Row(children: [
                  chat.connectId == null ? Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Post:',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(chat.postInfo?.title ?? '',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                color: Colors.white,
                                fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        Text('POSTED - ${chat.postInfo?.created != null ? DateFormat('MM/dd/yyyy').format(DateTime.parse(chat.postInfo!.created)) : ''}',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeOverSmall,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('POSTED IN ${chat.postInfo?.category ?? ''}',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeOverSmall,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ])) : Center(child: Text('Connect',
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                  const VerticalDivider(color: Colors.white, thickness: 2),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(currentUser(chat).name ?? '',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: Dimensions.paddingSizeMinimal),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Images.message),
                              Container(
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeExtraSmall),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.radiusExtraLarge)),
                                  ),
                                  child: Text('View >',
                                      style: TextStyle(
                                          decorationColor: Colors.white,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.fontSizeLarge))),
                            ])
                      ]))
                ])))));
  }

  AppUser currentUser(Chat chat) {
    if (chat.senderId == FirebaseAuth.instance.currentUser!.uid) {
      return chat.receiver!;
    } else {
      return chat.sender!;
    }
  }
}

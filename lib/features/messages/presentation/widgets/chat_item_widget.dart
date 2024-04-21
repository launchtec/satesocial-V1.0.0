import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

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
                    vertical: Dimensions.paddingSizeMinimal
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeMinimal,
                    horizontal: Dimensions.paddingSizeDefault),
                decoration: const BoxDecoration(
                  color: ColorConstants.secondColor,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
                ),
                child: IntrinsicHeight(child: Row(children: [
                  Column(
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
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        Text('POSTED - ${chat.postInfo?.created != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(chat.postInfo!.created)) : ''}',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeOverSmall,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('POSTED IN ${chat.postInfo?.category ?? ''}',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeOverSmall,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                  VerticalDivider(color: Colors.white, thickness: 2),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text(chat.receiver?.name ?? '',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(Images.message),
                      Container(
                          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius:
                            BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
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
}

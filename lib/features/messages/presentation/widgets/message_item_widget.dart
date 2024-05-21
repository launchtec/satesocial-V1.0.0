import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sate_social/features/messages/data/models/message.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/styles.dart';

class MessageItemWidget extends StatelessWidget {
  final Message message;
  final String ownerId;

  const MessageItemWidget(
      {super.key, required this.message, required this.ownerId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity / 2,
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall,
            horizontal: Dimensions.paddingSizeMinimal),
        child: Row(
            mainAxisAlignment: message.senderId == ownerId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: message.senderId == ownerId ? CrossAxisAlignment.start : CrossAxisAlignment.end, children: [
                Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall,
                        vertical: Dimensions.paddingSizeMinimal),
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                      color: message.senderId == ownerId
                          ? ColorConstants.secondColor
                          : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.radiusExtraLarge)),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(child: Text(message.text, textAlign: TextAlign.center))
                    ])),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Text('${DateFormat('d MMM hh:mm a').format(DateTime.parse(message.created))}',
                        style: const TextStyle(color: Colors.white)))
              ])
            ]));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  final bool isLastItem;

  const NotificationItemWidget({super.key, required this.notificationModel, required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeMinimal,
            horizontal: Dimensions.paddingSizeSmall),
        child: Column(children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Image.asset(Images.bell, height: 28),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Text(notificationModel.created,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSizeSmall)),
                    ]),
                    Column(children: [
                      Container(
                          width: context.width / 2,
                          child: Text(notificationModel.content,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.fontSizeDefault))),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(notificationModel.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.fontSizeSmall)),
                            Text(' - ${notificationModel.location}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.fontSizeSmall)),
                          ]),
                        ]),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: notificationModel.isOpen ? Colors.grey : ColorConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  ]),
              if (isLastItem)
                Divider()
            ]));
  }
}

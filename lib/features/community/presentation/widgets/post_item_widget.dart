import 'package:flutter/material.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class PostItemWidget extends StatelessWidget {
  final PostModel postModel;
  final Function onTap;

  const PostItemWidget({super.key, required this.postModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeMinimal, horizontal: Dimensions.paddingSizeSmall),
        child: InkWell(onTap: () => onTap(), child: Row(children: [
          Image.asset(Images.arrow, height: 24),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.title,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: Dimensions.fontSizeSmall)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(timeago.format(DateTime.parse(postModel.created)),
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontStyle: FontStyle.italic,
                  fontSize: Dimensions.fontSizeExtraSmall)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.strLocation ?? '',
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontStyle: FontStyle.italic,
                  fontSize: Dimensions.fontSizeExtraSmall)),
        ])));
  }
}
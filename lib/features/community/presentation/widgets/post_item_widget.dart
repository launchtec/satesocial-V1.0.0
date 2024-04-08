import 'package:flutter/material.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class PostItemWidget extends StatelessWidget {
  final PostModel postModel;

  const PostItemWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeMinimal),
        child: InkWell(onTap: (){}, child: Row(children: [
          Image.asset(Images.arrow, height: 24),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.title,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: Dimensions.fontSizeSmall)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.created,
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: Dimensions.fontSizeExtraSmall)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.zipCode,
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: Dimensions.fontSizeExtraSmall)),
        ])));
  }
}
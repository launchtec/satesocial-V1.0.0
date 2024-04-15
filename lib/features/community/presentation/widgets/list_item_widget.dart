import 'package:flutter/material.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class ListItemWidget extends StatelessWidget {
  final PostModel postModel;

  const ListItemWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeMinimal, horizontal: Dimensions.paddingSizeDefault),
        child: InkWell(onTap: (){}, child: Row(children: [
          Image.asset(Images.arrow, height: 32),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.title,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(timeago.format(DateTime.parse(postModel.created)),
              style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: Dimensions.fontSizeSmall)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(postModel.strLocation ?? '',
              style: TextStyle(
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      color: ColorConstants.primaryColor, // Choose the color of the shadow
                      blurRadius:
                      4.0, // Adjust the blur radius for the shadow effect
                      offset: Offset(0,
                          4.0), // Set the horizontal and vertical offset for the shadow
                    ),
                  ],
                  fontSize:
                  Dimensions.fontSizeSmall,
                  fontWeight: FontWeight.bold)),
        ])));
  }
}
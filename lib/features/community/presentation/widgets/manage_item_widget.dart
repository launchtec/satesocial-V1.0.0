import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

import '../../../../core/util/dimensions.dart';

class ManageItemWidget extends StatelessWidget {
  final PostModel postModel;
  final Function onDelete;
  final Function? onEdit;

  const ManageItemWidget({super.key, required this.postModel, required this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall,
            horizontal: Dimensions.paddingSizeDefault,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(width: context.width / 5, child: Text(postModel.shortCategory(),
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: postModel.colorCategory(),
                  shadows: const [
                    Shadow(
                      color: Colors.white, // Choose the color of the shadow
                      blurRadius:
                          4.0, // Adjust the blur radius for the shadow effect
                      offset: Offset(0,
                          4.0), // Set the horizontal and vertical offset for the shadow
                    ),
                  ],
                  fontSize: Dimensions.fontSizeLarge,
                  fontWeight: FontWeight.bold))),
          const SizedBox(width: Dimensions.paddingSizeDefault),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(postModel.title,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: Dimensions.fontSizeLarge)),
            Row(children: [
              TextButton(
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!();
                    }
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(onEdit != null ? 'Edit' : 'Check response',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge))),
              Text(' | ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontSizeLarge)),
              TextButton(
                  onPressed: () => onDelete(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge))),
            ]),
          ]),
        ]));
  }
}

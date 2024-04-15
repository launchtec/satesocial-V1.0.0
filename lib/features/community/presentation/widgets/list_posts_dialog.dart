import 'package:flutter/material.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/presentation/widgets/list_item_widget.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/styles.dart';

class ListPostsDialog extends StatelessWidget {
  final List<PostModel> posts;
  final ValueChanged<PostModel> selectPost;

  const ListPostsDialog({super.key, required this.posts, required this.selectPost});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titleTextStyle: TextStyle(
          fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
      content: SizedBox(
          width: double.maxFinite,
          child: Container(
              width: double.maxFinite,
              color: ColorConstants.listViewBackground,
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.fontSizeLarge, vertical: Dimensions.paddingSizeDefault),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(posts.first.imageBubleCategory(), height: 80),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Flexible(
                              child: Text(posts.first.titleListView(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      shadows: const [
                                        Shadow(
                                          color: Colors
                                              .black, // Choose the color of the shadow
                                          blurRadius:
                                              4.0, // Adjust the blur radius for the shadow effect
                                          offset: Offset(0,
                                              4.0), // Set the horizontal and vertical offset for the shadow
                                        ),
                                      ],
                                      fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.bold))),
                        ])),
                Expanded(
                    child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall,
                              horizontal: Dimensions.paddingSizeDefault),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return InkWell(child: ListItemWidget(postModel: posts[index]), onTap: () {
                              selectPost(posts[index]);
                              Navigator.pop(context);
                            });
                          }),
                    ),
              ]))),
      actions: null,
    );
  }
}

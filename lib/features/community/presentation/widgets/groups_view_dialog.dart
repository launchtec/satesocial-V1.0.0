import 'package:flutter/material.dart';
import 'package:sate_social/features/community/presentation/blocks/create_post/create_post_state.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/styles.dart';
import '../../data/models/post_category.dart';

class GroupsViewDialog extends StatelessWidget {
  final List<PostCategory> socialGroups;
  final CreatePostState postState;
  final ValueChanged<PostCategory> selectCategory;

  const GroupsViewDialog({super.key, required this.socialGroups, required this.postState, required this.selectCategory});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Post Group'),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall,
          vertical: Dimensions.paddingSizeSmall),
      titleTextStyle: TextStyle(
          fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: socialGroups.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              color: postState
                  .group == socialGroups[index].name ? ColorConstants.primaryColor : ColorConstants.cardAlertColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ), // Add elevation for the card effect
              child: InkWell(
                onTap: () {
                  selectCategory(socialGroups[index]);
                  Navigator.pop(context);
                },
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(socialGroups[index].imagePath, height: 40),
                        const SizedBox(height: Dimensions.paddingSizeMinimal),
                        Text(socialGroups[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeSmall))
                      ]),
                ),
              ),
            );
          },
        ),
      ),
      actions: null,
    );
  }
}

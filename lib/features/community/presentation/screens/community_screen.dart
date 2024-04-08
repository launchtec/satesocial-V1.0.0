import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/styles.dart';
import 'package:sate_social/features/community/presentation/widgets/post_item_widget.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/images.dart';
import '../../data/models/post_model.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<PostModel> featurePosts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(Images.logo, height: 65),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text(Get.find<String>(tag: 'city') ?? '',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeTitle,
                            shadows: const [
                              Shadow(
                                color: Colors
                                    .black, // Choose the color of the shadow
                                blurRadius:
                                    2.0, // Adjust the blur radius for the shadow effect
                                offset: Offset(-4.0,
                                    1.0), // Set the horizontal and vertical offset for the shadow
                              ),
                            ],
                            color: ColorConstants.secondColor)))
              ]),
              const Divider(color: Colors.grey, thickness: 5),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox(width: Dimensions.paddingSizeDefault),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                const SizedBox(width: Dimensions.paddingSizeDefault),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Text('Featured Listings',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeExtraLarge))),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                ),
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall,
                        horizontal: Dimensions.paddingSizeExtraSmall),
                    itemCount: featurePosts.length,
                    itemBuilder: (context, index) {
                      return PostItemWidget(postModel: featurePosts[index]);
                    }),
              )),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bublePost, height: 60),
                      onPressed: () => Get.toNamed(RouteHelper
                          .getCreatePostRoute())),
                  const Text('Post',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                Expanded(
                    child: Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bubleActivities,
                          width: context.width / 4),
                      onPressed: () {}),
                  const Text('Activities',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ])),
                Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bubleManage, height: 45),
                      onPressed: () {}),
                  const Text('Manage\nListings',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                const SizedBox(width: Dimensions.paddingSizeDefault),
              ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      IconButton(
                          icon: Image.asset(Images.bubleLove,
                              width: context.width / 4),
                          onPressed: () {}),
                      const Text('Love',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                    Column(children: [
                      IconButton(
                          icon: Image.asset(Images.bubleGig,
                              width: context.width / 4),
                          onPressed: () => Get.toNamed(RouteHelper
                              .getMapPostRoute())),
                      const Text('Gig',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ])
                  ]),
              const SizedBox(height: Dimensions.paddingSizeSmall)
            ])));
  }
}

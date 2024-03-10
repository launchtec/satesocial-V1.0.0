import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/styles.dart';

import '../../../../core/util/images.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.fitHeight,
                  opacity: 0.5),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(Images.logo, height: 80),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text('DENVER',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeTitle,
                            shadows: const [
                              Shadow(
                                color: Colors.black,      // Choose the color of the shadow
                                blurRadius: 2.0,          // Adjust the blur radius for the shadow effect
                                offset: Offset(-4.0, 1.0), // Set the horizontal and vertical offset for the shadow
                              ),
                            ],
                            color: ColorConstants.primaryColor)))
              ]),
              const Divider(color: Colors.grey, thickness: 6),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Column(children: [
                  Image.asset(Images.bublePost, height: 54),
                  const Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                Expanded(child: Column(children: [
                  Image.asset(Images.bubleActivities, width: context.width / 3),
                  const Text('Activities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ])),
                Column(children: [
                  Image.asset(Images.bubleManage, height: 54),
                  const Text('Manage\nListings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                const SizedBox(width: Dimensions.paddingSizeDefault),
              ]),
              Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  Image.asset(Images.bubleLove, width: context.width / 3),
                  const Text('Love', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Image.asset(Images.bubleGig, width: context.width / 3),
                  const Text('Gig', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ])
              ])
            ])));
  }
}

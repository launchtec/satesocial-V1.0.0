import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/styles.dart';

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
                  image: AssetImage("assets/image/back_community.png"),
                  fit: BoxFit.fitHeight,
                  opacity: 0.5),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset("assets/image/logo.png", height: 80),
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
              Row(children: [
                Column(children: []),
                Column(children: []),
                Column(children: [])
              ])
            ])));
  }
}

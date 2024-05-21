import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:fluttermoji/fluttermojiFunctions.dart';
import 'package:fluttermoji/fluttermojiSaveWidget.dart';
import 'package:get/get.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  late String city;

  @override
  void initState() {
    try {
      city = Get.find<String>(tag: 'city');
    } catch (exception) {
      city = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child: ListView(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  IconButton(
                      onPressed: () async {
                        String encodedData = await FluttermojiFunctions().encodeMySVGtoString();
                        String avatarSvg = await FluttermojiFunctions().decodeFluttermojifromString(encodedData);
                        Get.back(result: avatarSvg);
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.grey)),
                  Image.asset(Images.logo, height: 65),
                ]),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text(city,
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
              const SizedBox(height: Dimensions.paddingSizeOverLarge),
              Column(children: [
                FluttermojiCircleAvatar(),
                const SizedBox(height: Dimensions.paddingSizeMegaLarge),
                SizedBox(height: context.height / 2, child: FluttermojiCustomizer())
              ])
            ])));
  }
}

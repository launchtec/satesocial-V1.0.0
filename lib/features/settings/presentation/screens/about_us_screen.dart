import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AboutUsView();
  }
}

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding:
            const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backNotification),
                  fit: BoxFit.cover),
            ),
            child: Column(children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
                        Image.asset(Images.logo, height: 50),
                      ]),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.paddingSizeExtraLarge),
                          child: Text('ABOUT US',
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeTitle,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2.0,
                                      offset: Offset(-1.0, 1.0),
                                    ),
                                  ],
                                  color: Colors.black)))
                    ]),
                const Divider(color: Colors.grey, thickness: 2),
                Center(child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraLarge),
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor.withOpacity(0.4),
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge), child: Text(AppConstants.aboutUsText,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      fontWeight: FontWeight.w600))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault)
                            ])))
              ])
            ));
  }
}

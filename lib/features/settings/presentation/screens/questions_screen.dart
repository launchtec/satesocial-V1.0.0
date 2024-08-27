import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/dimensions.dart';

import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuestionsView();
  }
}

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
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
            child: ListView(padding: EdgeInsets.zero, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black)),
                  Image.asset(Images.logo, height: 50),
                ]),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text('HELP',
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
              const SizedBox(height: Dimensions.paddingSizeSmall),
              ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeSmall),
                        child: ExpansionTile(
                          title: Text(AppConstants.questionsList[index], style: TextStyle(fontWeight: FontWeight.w600)),
                          childrenPadding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          backgroundColor:
                              ColorConstants.primaryColor.withOpacity(0.4),
                          collapsedBackgroundColor:
                              ColorConstants.primaryColor.withOpacity(0.4),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radiusLarge))),
                          collapsedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radiusLarge))),
                          children: [
                            Text(AppConstants.answersList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSizeLarge))
                          ],
                        ));
                  },
                  itemCount: 7)
            ])));
  }
}

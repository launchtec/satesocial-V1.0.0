import 'package:flutter/material.dart';
import 'package:sate_social/core/util/styles.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';

class MatchFormDialog extends StatelessWidget {
  const MatchFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.radiusMaxLarge))),
      contentPadding: EdgeInsets.zero,
      titleTextStyle: TextStyle(
          fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
      content: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.radiusMaxLarge)),
          ),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: ColorConstants.matchPalette,
                ),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.radiusMaxLarge)),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: Dimensions.paddingSizeMiddleSmall),
                Image.asset(Images.match, height: 50),
                const SizedBox(height: Dimensions.paddingSizeMiddleSmall),
                Text('MATCH\nINTAKE FORM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                ElevatedButton(
                    onPressed: () async {
                      // Navigator.pop(context);
                      // Get.toNamed(RouteHelper.getOpenChatRoute(chat!));
                    },
                    style: ButtonStyle(
                        padding:
                        MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: Dimensions
                                    .paddingSizeMiddleSmall)),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('SELF MATCH INTAKE QUESTIONS >',
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorConstants.sendPingColor))
                        ])),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                ElevatedButton(
                    onPressed: () async {
                      // Navigator.pop(context);
                      // Get.toNamed(RouteHelper.getOpenChatRoute(chat!));
                    },
                    style: ButtonStyle(
                        padding:
                        MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: Dimensions
                                    .paddingSizeMiddleSmall)),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('PARTNER PREFERENCES QUESTIONS >',
                              style: TextStyle(
                                  color: ColorConstants.sendPingColor,
                                fontSize: Dimensions.fontSizeSmall
                              ))
                        ])),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ]))),
      actions: null,
    );
  }
}

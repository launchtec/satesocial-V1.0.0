import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset("assets/image/logo.png"),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(RouteHelper
                      .getSignInRoute()),
                  child: Text('Sign In',
                      style: TextStyle(fontSize: Dimensions.fontSizeLarge)))),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(RouteHelper
                      .getSignUpRoute()),
                  child: Text('Sign Up',
                      style: TextStyle(fontSize: Dimensions.fontSizeLarge)))),
        ])));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sate_social/core/util/images.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _version;

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.welcomeBack),
                fit: BoxFit.cover,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeOverLarge),
              Image.asset(Images.logo, height: 200),
              SizedBox(
                  width: context.width / 2.5,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide?>(
                            const BorderSide(color: Colors.grey, width: 1)),
                        elevation: MaterialStateProperty.all<double?>(5),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusOverLarge))),
                      ),
                      onPressed: () =>
                          Get.toNamed(RouteHelper.getSignInRoute()),
                      child: Row(children: [
                        Image.asset(Images.signInIcon,
                            height: 32),
                        Text('Sign In',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.black))
                      ]))),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              SizedBox(
                  width: context.width / 2.5,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide?>(
                            const BorderSide(color: Colors.grey, width: 1)),
                        elevation: MaterialStateProperty.all<double?>(5),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusOverLarge))),
                      ),
                      onPressed: () =>
                          Get.toNamed(RouteHelper.getSignUpRoute()),
                      child: Row(children: [
                        Image.asset(Images.signUpIcon,
                            height: 32),
                        Text('Sign Up',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.black))
                      ]))),
                  Expanded(child: Container()),
                  _version != null ? Text('Version $_version', style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeLarge)) : SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeOverLarge),
                ])));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/home/presentation/widgets/match_form_dialog.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';

class HomeScreen extends StatefulWidget {
  final PageController navController;
  const HomeScreen({super.key, required this.navController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.background),
                fit: BoxFit.cover,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Image.asset(Images.logo, height: context.height / 6),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset(Images.buble, height: context.height / 5),
                  Column(children: [
                    Image.asset(Images.connect, height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('CONNECT',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () => widget.navController.jumpToPage(2),
              ),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset(Images.purpleBuble, height: context.height / 5),
                  Column(children: [
                    Image.asset(Images.community, height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('COMMUNITY',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () => widget.navController.jumpToPage(3),
              ),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset(Images.buble, height: context.height / 5),
                  Column(children: [
                    Image.asset(Images.match, height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('MATCH',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () => showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return const MatchFormDialog();
                    }),
              )
            ])));
  }
}

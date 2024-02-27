import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                image: AssetImage("assets/image/back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Image.asset("assets/image/logo.png", height: 150),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset('assets/image/buble.png', height: 200),
                  Column(children: [
                    Image.asset('assets/image/connect.png', height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('CONNECT',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () {},
              ),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset('assets/image/purple_buble.png', height: 200),
                  Column(children: [
                    Image.asset('assets/image/community.png', height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('COMMUNITY',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () {},
              ),
              IconButton(
                icon: Stack(alignment: Alignment.center, children: [
                  Image.asset('assets/image/buble.png', height: 200),
                  Column(children: [
                    Image.asset('assets/image/match.png', height: 50),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text('MATCH',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])
                ]),
                onPressed: () {},
              )
            ])));
  }
}

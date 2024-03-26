import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({super.key});

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            appBar: null,
            backgroundColor: ColorConstants.backColor,
            body: Container(
                width: double.infinity,
                color: Colors.black,
                child: ListView(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.grey)),
                          Image.asset(Images.logo, height: 65),
                        ]),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.paddingSizeExtraLarge),
                            child: Text('DENVER',
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
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Center(
                      child: Text('Community Posting',
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeOverLarge,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    decoration: const BoxDecoration(
                      color: ColorConstants.shapeColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radiusLarge)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Row(children: [
                                Text('Category: ',
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeSmall),
                                  buttonStyleData: const ButtonStyleData(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.radiusSmall))),
                                      padding: EdgeInsets.zero),
                                  value: AppConstants.postCategories[0],
                                  onChanged: (String? value) {
                                    // context.read<SignUpCubit>().sexualityChanged(value!);
                                  },
                                  items: AppConstants.postCategories
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                )),
                              ])),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Row(children: [
                                Text('Select Post Group: ',
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                    child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeSmall),
                                  buttonStyleData: const ButtonStyleData(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.radiusSmall))),
                                      padding: EdgeInsets.zero),
                                  value: AppConstants.romanceGroups[0],
                                  onChanged: (String? value) {
                                    // context.read<SignUpCubit>().sexualityChanged(value!);
                                  },
                                  items: AppConstants.romanceGroups
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                )),
                              ])),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Text('Posting Title:',
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(height: Dimensions.paddingSizeSmall),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: TextField(
                                key: const Key('post_postingTitle_textField'),
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeDefault),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: Dimensions.paddingSizeSmall),
                                  hintText: 'Type In',
                                  hintStyle: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault),
                                  border: InputBorder.none,
                                ),
                                onChanged: (String value) {},
                              )),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Text('Zip Code:',
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: TextField(
                                key: const Key('post_zipCode_textField'),
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeDefault),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: Dimensions.paddingSizeSmall),
                                  hintText: 'Type In',
                                  hintStyle: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault),
                                  border: InputBorder.none,
                                ),
                                onChanged: (String value) {},
                              )),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                        ]),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraLarge),
                      child: Row(children: [
                        Text('Post:',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ])),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: TextField(
                        key: const Key('post_zipCode_textField'),
                        focusNode: focusNode,
                        style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                        maxLines: 7,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeDefault,
                              horizontal: Dimensions.paddingSizeSmall),
                          hintText: 'Type In',
                          hintStyle:
                              TextStyle(fontSize: Dimensions.fontSizeDefault),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusLarge),
                          ),
                        ),
                        onChanged: (String value) {},
                      )),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraLarge),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.primaryColor)),
                                child: const Text('Submit', style: TextStyle(color: Colors.white)))
                          ]))
                ]))));
  }
}

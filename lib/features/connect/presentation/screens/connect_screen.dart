import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';
import 'package:sate_social/features/auth/domain/use_cases/user_info_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_info/user_info_cubit.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_info/user_info_state.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserInfoCubit(
              userInfoCase: UserInfoCase(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
        child: const ConnectView());
  }
}

class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  late AppUser appUser;
  bool isRomantic = false;
  bool isSocial = false;
  bool isGig = false;
  @override
  void initState() {
    context.read<UserInfoCubit>().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(Images.logo, height: 65),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text('YOUR CARD',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeTitle,
                            shadows: const [
                              Shadow(
                                color: ColorConstants
                                    .primaryColor, // Choose the color of the shadow
                                blurRadius:
                                    2.0, // Adjust the blur radius for the shadow effect
                                offset: Offset(-4.0,
                                    1.0), // Set the horizontal and vertical offset for the shadow
                              ),
                            ],
                            color: Colors.orange)))
              ]),
              const Divider(color: Colors.grey, thickness: 5),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Expanded(child: BlocBuilder<UserInfoCubit, UserInfoState>(
                  builder: (blocContext, state) {
                if (state.user != null) {
                  appUser = state.user!;
                  isRomantic = state.user!.openToConnectTo.contains(AppConstants.openToConnectToList[0]);
                  isSocial = state.user!.openToConnectTo.contains(AppConstants.openToConnectToList[1]);
                  isGig = state.user!.openToConnectTo.contains(AppConstants.openToConnectToList[2]);
                }
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraLarge),
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                    color: ColorConstants.backConnectColor.withOpacity(0.7),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Dimensions.radiusLarge)),
                  ),
                  child: !state.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Image.asset(Images.avatar,
                                  height: context.height / 9,
                                  fit: BoxFit.contain),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  width: context.width / 2,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        // Get.toNamed(RouteHelper.getCommunityChatsRoute());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor,
                                          elevation: 4,
                                          shadowColor: Colors.white,
                                          minimumSize: const Size(100, 28),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(Images.avatarConnect,
                                                height: 18),
                                            Text('CREATE YOUR AVATAR',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Image.asset(Images.arrowConnect,
                                                height: 18)
                                          ]))),
                              Container(
                                  width: context.width / 2,
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(RouteHelper.getMapConnectRoute());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.secondColor,
                                          minimumSize: const Size(100, 28),
                                          elevation: 4,
                                          shadowColor: Colors.white,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(Images.nearbyConnect,
                                                height: 18),
                                            Text('NEARBY CARDS',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Image.asset(Images.arrowConnect,
                                                height: 18)
                                          ]))),
                              Container(
                                  width: context.width / 2,
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(RouteHelper.getConnectChatsRoute());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          minimumSize: const Size(100, 28),
                                          elevation: 4,
                                          shadowColor: Colors.white,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(Images.messageConnect,
                                                height: 18),
                                            Text('MESSAGES',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Image.asset(Images.arrowConnect,
                                                height: 18)
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Text('Your Profile Info',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.fontSizeExtraLarge)),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Text('Age:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Dimensions
                                                      .fontSizeDefault)),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          SizedBox(
                                              width: context.width / 4,
                                              child: DropdownButtonFormField2<
                                                  String>(
                                                isExpanded: true,
                                                value: appUser.age.toString(),
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color: Colors.black),
                                                decoration:
                                                    const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        border:
                                                            InputBorder.none),
                                                buttonStyleData: const ButtonStyleData(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .all(Radius.circular(
                                                                Dimensions
                                                                    .radiusSmall))),
                                                    padding: EdgeInsets.zero),
                                                hint: const Text(
                                                  'Age',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                onChanged: (String? value) {
                                                  // AppUser.fromMap(json)
                                                },
                                                items: AppConstants.ageList.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: value,
                                                      child: Text(value));
                                                }).toList(),
                                              )),
                                        ]),
                                        Row(children: [
                                          Text('Height:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Dimensions
                                                      .fontSizeDefault)),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          SizedBox(
                                              width: context.width / 3.5,
                                              child: DropdownButtonFormField2<
                                                  String>(
                                                isExpanded: true,
                                                value: appUser.height,
                                                style: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                    color: Colors.black),
                                                decoration:
                                                    const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        border:
                                                            InputBorder.none),
                                                buttonStyleData: const ButtonStyleData(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .all(Radius.circular(
                                                                Dimensions
                                                                    .radiusSmall))),
                                                    padding: EdgeInsets.zero),
                                                hint: const Text(
                                                  'Height',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                onChanged: (String? value) {
                                                  // blocContext.read<SignUpCubit>().heightChanged(value!);
                                                },
                                                items: AppConstants.heightList
                                                    .map<DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: value,
                                                      child: Text(value));
                                                }).toList(),
                                              )),
                                        ])
                                      ])),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Ethnicity:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    const SizedBox(
                                        width:
                                            Dimensions.paddingSizeExtraSmall),
                                    Expanded(
                                        child: DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      value: appUser.ethnicity,
                                      style: TextStyle(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none),
                                      buttonStyleData: const ButtonStyleData(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radiusSmall))),
                                          padding: EdgeInsets.zero),
                                      hint: const Text(
                                        'Ethnicity',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      onChanged: (String? value) {
                                        // blocContext.read<SignUpCubit>().heightChanged(value!);
                                      },
                                      items: AppConstants.ethnicityList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    )),
                                  ])),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Gender:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    const SizedBox(
                                        width:
                                            Dimensions.paddingSizeExtraSmall),
                                    Expanded(
                                        child: DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      value: appUser.gender,
                                      style: TextStyle(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none),
                                      buttonStyleData: const ButtonStyleData(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radiusSmall))),
                                          padding: EdgeInsets.zero),
                                      hint: const Text(
                                        'Gender',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      onChanged: (String? value) {
                                        // blocContext.read<SignUpCubit>().heightChanged(value!);
                                      },
                                      items: AppConstants.genderList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    )),
                                  ])),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Sexuality:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    const SizedBox(
                                        width:
                                            Dimensions.paddingSizeExtraSmall),
                                    Expanded(
                                        child: DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      value: appUser.sexuality,
                                      style: TextStyle(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none),
                                      buttonStyleData: const ButtonStyleData(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      Dimensions.radiusSmall))),
                                          padding: EdgeInsets.zero),
                                      hint: const Text(
                                        'Sexuality',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      onChanged: (String? value) {
                                        // blocContext.read<SignUpCubit>().heightChanged(value!);
                                      },
                                      items: AppConstants.sexualityList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    )),
                                  ])),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Open to connect:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault))
                                  ])),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          SizedBox(
                                              height: 32.0,
                                              width: 32.0,
                                              child: Checkbox(
                                                  value: isRomantic,
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isRomantic = value!;
                                                    });
                                                  })),
                                          Text('Romantically',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall)),
                                        ]),
                                        Row(children: [
                                          SizedBox(
                                              height: 32.0,
                                              width: 32.0,
                                              child: Checkbox(
                                                  value: isSocial,
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isSocial = value!;
                                                    });
                                                  })),
                                          Text('Friends',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall)),
                                        ]),
                                        Row(children: [
                                          SizedBox(
                                              height: 32.0,
                                              width: 32.0,
                                              child: Checkbox(
                                                  value: isGig,
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isGig = value!;
                                                    });
                                                  })),
                                          Text('Professionally',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall)),
                                        ])
                                      ])),
                              const SizedBox(height: Dimensions.paddingSizeDefault),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  width: context.width / 3,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        // Get.toNamed(RouteHelper.getCommunityChatsRoute());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor,
                                          elevation: 4,
                                          shadowColor: Colors.white,
                                          minimumSize: const Size(100, 28),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeMiddleSmall)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Save',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]))),
                            ])
                      : const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.0)),
                );
              })),
              const SizedBox(height: Dimensions.paddingSizeDefault),
            ])));
  }
}

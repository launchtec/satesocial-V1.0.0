import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_avatar_case.dart';
import 'package:sate_social/features/auth/domain/use_cases/user_info_case.dart';
import 'package:sate_social/features/auth/domain/use_cases/user_update_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/update_avatar/update_avatar_cubit.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_info/user_info_cubit.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_info/user_info_state.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_update/user_update_cubit.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_update/user_update_state.dart';
import 'package:sate_social/features/connect/presentation/widgets/sexuality_drop.dart';

import '../../../../core/data/blocks/request_status.dart';
import '../../../../core/route/route_helper.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../auth/presentation/blocks/update_activity/update_activity_cubit.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => UserInfoCubit(
                userInfoCase: UserInfoCase(
                  authRepository: context.read<AuthRepository>(),
                ),
              )),
      BlocProvider(
          create: (context) => UserUpdateCubit(
                userUpdateCase: UserUpdateCase(
                  authRepository: context.read<AuthRepository>(),
                ),
              )),
      BlocProvider(
          create: (context) => UpdateAvatarCubit(
                updateAvatarCase: UpdateAvatarCase(
                  authRepository: context.read<AuthRepository>(),
                ),
              ))
    ], child: const ConnectView());
  }
}

class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  final TextEditingController _instagramController = TextEditingController();
  AppUser? appUser;
  @override
  void initState() {
    context.read<UserInfoCubit>().getUserInfo();
    context.read<UpdateActivityCubit>().updateActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
            padding:
                const EdgeInsets.only(top: Dimensions.paddingSizeExtremeLarge),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.backCommunity),
                  fit: BoxFit.cover,
                  opacity: 0.4),
            ),
            child:
                ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Image.asset(Images.logo, height: 50),
                Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeExtraLarge),
                    child: Text('YOUR CARD',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeTitle,
                            shadows: const [
                              Shadow(
                                color: ColorConstants
                                    .primaryColor,
                                blurRadius:
                                    2.0,
                                offset: Offset(-4.0,
                                    1.0),
                              ),
                            ],
                            color: Colors.orange)))
              ]),
              const Divider(color: Colors.grey, thickness: 4),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              BlocBuilder<UserInfoCubit, UserInfoState>(
                  builder: (blocContext, state) {
                if (state.user != null) {
                  appUser = state.user!;
                  context
                      .read<UserUpdateCubit>()
                      .openToConnectToChanged(state.user!.openToConnectTo);
                  context.read<UserUpdateCubit>().relationshipActiveChanged(
                      state.user!.activeRelationship ?? false);
                  context.read<UserUpdateCubit>().instagramActiveChanged(
                      state.user!.activeInstagram ?? false);
                  _instagramController.text =
                      state.user!.userLinkInstagram ?? '';
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
                              appUser!.avatar == null
                                  ? Image.asset(Images.avatar,
                                      height: 48, fit: BoxFit.contain)
                                  : SizedBox(
                                      height: 48,
                                      child: FluttermojiCircleAvatar()),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  width: context.width / 1.8,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        String result = await Get.toNamed(
                                            RouteHelper.getAvatarRoute());
                                        context
                                            .read<UpdateAvatarCubit>()
                                            .updateAvatar(AvatarUser(
                                                avatar: result,
                                                lastActivity: DateTime.now()
                                                    .toIso8601String()));
                                        context.read<UserInfoCubit>().getUserInfo();
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
                                  width: context.width / 1.8,
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(
                                            RouteHelper.getMapConnectRoute());
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
                                  width: context.width / 1.8,
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Get.toNamed(
                                            RouteHelper.getConnectChatsRoute());
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
                              Text('Your Profile Info',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.fontSizeExtraLarge)),
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
                                                value: appUser?.age.toString(),
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
                                                  context
                                                      .read<UserUpdateCubit>()
                                                      .ageChanged(
                                                          int.parse(value!));
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
                                                value: appUser?.height,
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
                                                  context
                                                      .read<UserUpdateCubit>()
                                                      .heightChanged(value!);
                                                },
                                                items: AppConstants.heightList
                                                    .map<
                                                            DropdownMenuItem<
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
                                      value: appUser?.ethnicity,
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
                                        context
                                            .read<UserUpdateCubit>()
                                            .ethnicityChanged(value!);
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
                                      value: appUser?.gender,
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
                                        context
                                            .read<UserUpdateCubit>()
                                            .genderChanged(value!);
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
                                        child: SexualityDrop(
                                            initialValue: appUser?.sexuality,
                                            onChanged: (value) {
                                              context
                                                  .read<UserUpdateCubit>()
                                                  .sexualityChanged(value);
                                            })),
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
                                                  value: context
                                                      .read<UserUpdateCubit>()
                                                      .state
                                                      .openToConnectTo
                                                      ?.contains(AppConstants
                                                          .openToConnectToList[0]),
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .addOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[0]);
                                                      } else {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .removeOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[0]);
                                                      }
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
                                                  value: context
                                                      .read<UserUpdateCubit>()
                                                      .state
                                                      .openToConnectTo
                                                      ?.contains(AppConstants
                                                          .openToConnectToList[1]),
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .addOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[1]);
                                                      } else {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .removeOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[1]);
                                                      }
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
                                                  value: context
                                                      .read<UserUpdateCubit>()
                                                      .state
                                                      .openToConnectTo
                                                      ?.contains(AppConstants
                                                          .openToConnectToList[2]),
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.green,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value!) {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .addOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[2]);
                                                      } else {
                                                        context
                                                            .read<
                                                                UserUpdateCubit>()
                                                            .removeOpenToConnectToChanged(
                                                                AppConstants
                                                                    .openToConnectToList[2]);
                                                      }
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
                              const SizedBox(
                                  height: Dimensions.paddingSizeMinimal),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Relationship status:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    Transform.scale(
                                        scale: 0.8,
                                        child: SizedBox(
                                            height: 20,
                                            child: Switch(
                                                value: context
                                                    .read<UserUpdateCubit>()
                                                    .state
                                                    .activeRelationship!,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                onChanged: (value) {
                                                  setState(() {
                                                    context
                                                        .read<UserUpdateCubit>()
                                                        .relationshipActiveChanged(
                                                            value);
                                                  });
                                                }))),
                                    Text('ACTIVE ON CARD',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize:
                                                Dimensions.fontSizeOverSmall)),
                                  ])),
                              const SizedBox(
                                  height: Dimensions.paddingSizeMinimal),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Expanded(
                                        child: DropdownButtonFormField2<String>(
                                      value: appUser?.relationship,
                                      isExpanded: true,
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
                                        'Relationship status',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      onChanged: (String? value) {
                                        context
                                            .read<UserUpdateCubit>()
                                            .relationshipChanged(value!);
                                      },
                                      items: AppConstants.relationships
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    )),
                                  ])),
                              const SizedBox(
                                  height: Dimensions.paddingSizeMinimal),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Row(children: [
                                    Text('Link your Instagram!',
                                        style: TextStyle(
                                            color:
                                                ColorConstants.textInstaColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    Transform.scale(
                                        scale: 0.8,
                                        child: SizedBox(
                                            height: 20,
                                            child: Switch(
                                                value: context
                                                    .read<UserUpdateCubit>()
                                                    .state
                                                    .activeInstagram!,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                onChanged: (value) {
                                                  setState(() {
                                                    context
                                                        .read<UserUpdateCubit>()
                                                        .instagramActiveChanged(
                                                            value);
                                                  });
                                                }))),
                                    Text('ACTIVE ON CARD',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize:
                                                Dimensions.fontSizeOverSmall)),
                                  ])),
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Stack(children: [
                                    SizedBox(
                                        height: 30,
                                        child: TextField(
                                          key: const Key('inst_textField'),
                                          controller: _instagramController,
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                          decoration: InputDecoration(
                                            filled: true,
                                            isDense: false,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(Dimensions
                                                    .paddingSizeSmall),
                                            hintText: '@YourUserName',
                                            hintStyle: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSizeDefault),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (String value) {
                                            context
                                                .read<UserUpdateCubit>()
                                                .userLinkInstagramChanged(
                                                    value);
                                          },
                                        )),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image.asset(Images.instagramConnect,
                                              height: 36, fit: BoxFit.contain),
                                        ])
                                  ])),
                              const SizedBox(
                                  height: Dimensions.paddingSizeMinimal),
                              BlocConsumer<UserUpdateCubit, UserUpdateState>(
                                  listener: (context, state) {
                                if (state.requestStatus ==
                                    RequestStatus.submissionFailure) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'An error occurred while updating your profile. Try again',
                                        ),
                                      ),
                                    );
                                }
                                if (state.requestStatus ==
                                    RequestStatus.submissionSuccess) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'The profile has been successfully updated',
                                        ),
                                      ),
                                    );
                                }
                              }, builder: (context, state) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.paddingSizeMinimal),
                                    width: context.width / 3,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          context
                                              .read<UserUpdateCubit>()
                                              .updateUserInfo(appUser!);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstants.primaryColor,
                                            elevation: 4,
                                            shadowColor: Colors.white,
                                            minimumSize: const Size(100, 28),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
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
                                            ])));
                              }),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault)
                            ])
                      : const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.0)),
                );
              }),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            ])));
  }
}

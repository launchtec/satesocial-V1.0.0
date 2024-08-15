import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/domain/use_cases/sign_out_use_case.dart';
import '../../../auth/domain/use_cases/user_info_case.dart';
import '../../../auth/presentation/blocks/sign_out/sign_out_cubit.dart';
import '../../../auth/presentation/blocks/sign_out/sign_out_state.dart';
import '../../../auth/presentation/blocks/user_info/user_info_cubit.dart';
import '../../../auth/presentation/blocks/user_info/user_info_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        create: (context) => SignOutCubit(
          signOutUseCase: SignOutUseCase(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        child: const SettingsView(),
      )
    ], child: const SettingsView());
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool notificationActive = false;

  @override
  void initState() {
    context.read<UserInfoCubit>().getUserInfo();
    getNotificationsStatus();
    super.initState();
  }

  Future<void> getNotificationsStatus() async {
    notificationActive = await Utils.getNotificationsStatus();
    setState(() {});
  }

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
            child: BlocConsumer<SignOutCubit, SignOutState>(
                listener: (context, state) {
              if (state is SuccessSignOutState) {
                Get.offAndToNamed(RouteHelper.getWelcomeRoute());
              }
            }, builder: (context, state) {
              return Column(children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Images.logo, height: 50),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.paddingSizeExtraLarge),
                          child: Text('SETTINGS',
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
                Expanded(
                    child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraLarge),
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusLarge)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                              BlocBuilder<UserInfoCubit, UserInfoState>(
                                  builder: (blocContext, state) {
                                return Column(children: [
                                  Text('Hello ${state.user?.name ?? 'Guest'}',
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                      height:
                                          Dimensions.paddingSizeExtremeLarge),
                                ]);
                              }),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeOverLarge),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor),
                                      onPressed: () {
                                        context.read<SignOutCubit>().signOut();
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(Images.logoutIcon,
                                                height: Dimensions.iconSize,
                                                width: Dimensions.iconSize),
                                            const Text('Log Out',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const Icon(
                                                Icons.chevron_right_rounded,
                                                color: Colors.white)
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeOverLarge),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeDefault,
                                          horizontal:
                                              Dimensions.paddingSizeDefault),
                                      decoration: BoxDecoration(
                                          color: ColorConstants.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusLarge)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('App Notifications',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                                height: 20,
                                                child: Switch(
                                                    value: notificationActive,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    activeColor: Colors.green,
                                                    activeTrackColor:
                                                        Colors.white,
                                                    inactiveThumbColor:
                                                        ColorConstants
                                                            .primaryColor,
                                                    onChanged: (value) {
                                                      if (value) {
                                                        FirebaseMessaging.instance.getToken();
                                                      } else {
                                                        FirebaseMessaging.instance.deleteToken();
                                                      }
                                                      Utils.saveNotificationsStatus(value);
                                                      setState(() {
                                                        notificationActive =
                                                            value;
                                                      });
                                                    })),
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeOverLarge),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor),
                                      onPressed: () => Get.toNamed(
                                          RouteHelper.getQuestionsRoute()),
                                      child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.question_mark,
                                                color: Colors.white),
                                            Text('Help Section',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Icon(Icons.chevron_right_outlined,
                                                color: Colors.white)
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeOverLarge),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor),
                                      onPressed: () {
                                        launchUrlString(AppConstants.privacyPolicyLink);
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(Images.shieldIcon,
                                                height: Dimensions.iconSize,
                                                width: Dimensions.iconSize),
                                            const Text('Privicy policy',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const Icon(
                                                Icons.chevron_right_rounded,
                                                color: Colors.white)
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeOverLarge),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor),
                                      onPressed: () => Get.toNamed(
                                      RouteHelper.getAboutUsRoute()),
                                      child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                            Text('About us',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Icon(
                                                Icons.chevron_right_rounded,
                                                color: Colors.white)
                                          ]))),
                              const SizedBox(
                                  height: Dimensions.paddingSizeDefault),
                            ])))
              ]);
            })));
  }
}

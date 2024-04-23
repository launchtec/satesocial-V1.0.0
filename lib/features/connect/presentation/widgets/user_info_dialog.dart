import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat_connect/add_chat_connect_state.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/app_constants.dart';
import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../messages/domain/use_cases/add_message_case.dart';
import '../../../messages/presentation/blocks/add_chat_connect/add_chat_connect_cubit.dart';
import '../../../messages/presentation/blocks/add_message/add_message_cubit.dart';

class UserInfoDialog extends StatelessWidget {
  final AppUser user;

  const UserInfoDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddChatConnectCubit(
                    addChatCase: AddChatCase(
                      chatRepository: context.read<ChatRepository>(),
                    ),
                  )),
          BlocProvider(
              create: (context) => AddMessageCubit(
                  addMessageCase: AddMessageCase(
                    chatRepository: context.read<ChatRepository>(),
                  )))
        ],
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: TextStyle(
              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.black),
          content: BlocBuilder<AddChatConnectCubit, AddChatConnectState>(
              builder: (context, state) {
            return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                ),
                child: Stack(children: [
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: user.gender == AppConstants.genderList[0]
                                ? ColorConstants.malePalette
                                : user.gender == AppConstants.genderList[1]
                                    ? ColorConstants.femalePalette
                                    : ColorConstants.nonbinaryPalette,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radiusLarge),
                              topLeft: Radius.circular(Dimensions.radiusLarge)),
                        ),
                        child: Column(children: [
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Image.asset(Images.avatar, height: 64),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text('Active 5 minutes ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeExtraLarge)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          IntrinsicHeight(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text('${user.age ?? ''}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                                const VerticalDivider(
                                    thickness: 2, color: Colors.white),
                                Text(user.gender ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                                const VerticalDivider(
                                    thickness: 2, color: Colors.white),
                                Text(user.height ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fontSizeDefault)),
                              ])),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.ethnicity ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          Text(user.sexuality,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall),
                          user.relationship != null &&
                                  user.relationship!.isNotEmpty
                              ? Column(children: [
                                  Text(user.relationship!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Dimensions.fontSizeDefault)),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall),
                                ])
                              : const SizedBox(),
                          Text(
                              'Interested in: ${user.openToConnectTo.join(', ')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeLarge)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtremeLarge),
                        ])),
                    Container(
                        width: double.infinity,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: ColorConstants.greyBack,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(Dimensions.radiusLarge),
                              bottomRight:
                                  Radius.circular(Dimensions.radiusLarge)),
                        ))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white60, size: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]),
                  Positioned(
                      bottom: 80,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.sending,
                                      height: 24,
                                      color: ColorConstants.sendPingColor),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                  Text('SEND PING',
                                      style: TextStyle(
                                          color: ColorConstants.sendPingColor,
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.bold))
                                ]),
                            iconStyleData: const IconStyleData(
                              iconSize: 0,
                            ),
                            items: AppConstants.listHello
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) async {
                              String chatId = await context
                                  .read<AddChatConnectCubit>()
                                  .addChat(user);
                              await context
                                  .read<AddMessageCubit>()
                                  .addMessage(chatId,
                                  value!);
                              Navigator.pop(context);
                              Get.toNamed(RouteHelper.getConnectChatsRoute());
                            },
                            buttonStyleData: ButtonStyleData(
                              width: context.width / 2,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: Colors.white,
                              ),
                              elevation: 2,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: context.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      )),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ((user.activeInstagram ?? false) &&
                                user.userLinkInstagram != null)
                            ? Row(children: [
                                Image.asset(Images.instagramConnect,
                                    height: 48),
                                Text(user.userLinkInstagram!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeDefault)),
                              ])
                            : Container()),
                  ),
                ]));
          }),
          actions: null,
        ));
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/maps_util.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';
import 'package:sate_social/features/auth/domain/use_cases/get_users_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/get_users/get_users_cubit.dart';
import 'package:sate_social/features/auth/presentation/blocks/get_users/get_users_state.dart';
import 'package:sate_social/features/connect/presentation/widgets/user_info_dialog.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_chats_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chats/get_chats_cubit.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chats/get_chats_state.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';

class MapConnectScreen extends StatelessWidget {
  const MapConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetUsersCubit(
                  getUsersCase: GetUsersCase(
                    authRepository: context.read<AuthRepository>(),
                  ),
                )),
        BlocProvider(
            create: (context) => GetChatsCubit(
                  getChatsCase: GetChatsCase(
                    chatRepository: context.read<ChatRepository>(),
                  ),
                ))
      ],
      child: const MapConnectView(),
    );
  }
}

class MapConnectView extends StatefulWidget {
  const MapConnectView({super.key});

  @override
  State<MapConnectView> createState() => _MapConnectViewState();
}

class _MapConnectViewState extends State<MapConnectView> {
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _currentPosition;
  Position? _position;
  List<AppUser> users = [];
  List<Chat> chats = [];

  @override
  void initState() {
    try {
      _position = Get.find<Position>(tag: 'coordinates');
      _currentPosition = CameraPosition(
        target: LatLng(_position!.latitude, _position!.longitude),
        zoom: 12,
      );
    } on Exception {
      _currentPosition = const CameraPosition(
        target: LatLng(39.7413907, -104.9982888),
        zoom: 12,
      );
    }
    context.read<GetUsersCubit>().getUsers();
    context
        .read<GetChatsCubit>()
        .getChats(FirebaseAuth.instance.currentUser!.uid, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: MultiBlocListener(
            listeners: [
              BlocListener<GetUsersCubit, GetUsersState>(
                  listener: (context, state) {
                if (markers.isEmpty && state.users.isNotEmpty) {
                  users.clear();
                  for (AppUser appUser in state.users) {
                    if (appUser.id != FirebaseAuth.instance.currentUser!.uid) {
                      users.add(appUser);
                    }
                  }
                  addingMarkersInMap(context);
                }
              }),
              BlocListener<GetChatsCubit, GetChatsState>(
                  listener: (context, state) {
                if (chats.isEmpty && state.chats.isNotEmpty) {
                  chats = state.chats.toList();
                }
              })
            ],
            child: Container(
                padding:
                    const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeSmall),
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
                                child: Text(Get.find<String>(tag: 'city') ?? '',
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
                      const Divider(
                          color: Colors.grey,
                          thickness: 5,
                          height: Dimensions.paddingSizeExtraSmall),
                      Expanded(
                          child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _currentPosition,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        markers: markers,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ))
                    ]))));
  }

  Chat? getChatForUser(String userId) {
    Chat? userChat;
    for (Chat chat in chats) {
      if (chat.receiverId == userId) {
        userChat = chat;
        break;
      }
    }
    return userChat;
  }

  Future<void> addingMarkersInMap(BuildContext context) async {
    Set<Marker> tempMarkers = {};
    for (AppUser user in users) {
      if (user.latitude != null && user.longitude != null) {
        tempMarkers.add(Marker(
          markerId: MarkerId(const Uuid().v4()),
          position: LatLng(
            user.latitude!,
            user.longitude!,
          ),
          icon: await getCustomIcon(user),
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return UserInfoDialog(
                      user: user, chat: getChatForUser(user.id));
                });
          },
        ));
      }
    }
    setState(() {
      markers = tempMarkers;
    });
  }

  Future<BitmapDescriptor> getCustomIcon(AppUser user) async {
    return SizedBox(
      height: 100,
      width: 100,
      child: user.gender == AppConstants.genderList[0]
          ? (user.avatar!.isEmpty
              ? Image.asset(Images.maleMarker, fit: BoxFit.contain)
              : Stack(alignment: Alignment.topCenter, children: [
                  Image.asset(Images.emptyMaleMarker, height: 100, fit: BoxFit.contain),
                  SvgPicture.string(
                    user.avatar!,
                    width: 65,
                    height: 65,
                  )
                ]))
          : user.gender == AppConstants.genderList[1]
              ? (user.avatar!.isEmpty
                  ? Image.asset(Images.femaleMarker, height: 100, fit: BoxFit.contain)
                  : Stack(children: [
                      Image.asset(Images.emptyFemaleMarker,
                          fit: BoxFit.contain),
                      SvgPicture.string(
                        user.avatar!,
                        width: 65,
                        height: 65,
                      )
                    ]))
              : (user.avatar!.isEmpty
                  ? Image.asset(Images.nonbinaryMarker, height: 100, fit: BoxFit.contain)
                  : Stack(children: [
                      Image.asset(Images.emptyNonbinaryMarker,
                          fit: BoxFit.contain),
                      SvgPicture.string(
                        user.avatar!,
                        width: 65,
                        height: 65,
                      )
                    ])),
    ).toBitmapDescriptor();
  }
}

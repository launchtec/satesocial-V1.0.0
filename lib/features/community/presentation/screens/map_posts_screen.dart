import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/maps_util.dart';
import 'package:sate_social/features/community/domain/use_cases/category_posts_case.dart';
import 'package:sate_social/features/community/presentation/blocks/category_posts/category_posts_cubit.dart';
import 'package:sate_social/features/community/presentation/widgets/list_posts_dialog.dart';
import 'package:sate_social/features/community/presentation/widgets/post_info_dialog.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../messages/domain/repositories/chat_repository.dart';
import '../../../messages/domain/use_cases/get_chats_case.dart';
import '../../../messages/presentation/blocks/get_chats/get_chats_cubit.dart';
import '../../../messages/presentation/blocks/get_chats/get_chats_state.dart';
import '../../data/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';
import '../blocks/category_posts/category_posts_state.dart';

class MapPostsScreen extends StatelessWidget {
  final String category;
  const MapPostsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CategoryPostsCubit(
                  postsCategoryCase: CategoryPostsCase(
                    postRepository: context.read<PostRepository>(),
                  ),
                )),
        BlocProvider(
            create: (context) => GetChatsCubit(
                  getChatsCase: GetChatsCase(
                    chatRepository: context.read<ChatRepository>(),
                  ),
                ))
      ],
      child: MapPostsView(category: category),
    );
  }
}

class MapPostsView extends StatefulWidget {
  final String category;
  const MapPostsView({super.key, required this.category});

  @override
  State<MapPostsView> createState() => _MapPostsViewState();
}

class _MapPostsViewState extends State<MapPostsView> {
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _currentPosition;
  Position? _position;
  List<PostModel> posts = [];
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
    final queryCategory = widget.category == 'romance'
        ? AppConstants.postCategories[0]
        : (widget.category == 'social'
            ? AppConstants.postCategories[1]
            : AppConstants.postCategories[2]);
    context.read<CategoryPostsCubit>().getCategoryPosts(queryCategory);
    context
        .read<GetChatsCubit>()
        .getChats(FirebaseAuth.instance.currentUser!.uid, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: MultiBlocListener(
            listeners: [
              BlocListener<CategoryPostsCubit, CategoryPostsState>(
                  listener: (context, state) {
                if (markers.isEmpty && state.postModels.isNotEmpty) {
                  posts = state.postModels;
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
                          child: Stack(children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _currentPosition,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          markers: markers,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                        Positioned(
                          bottom: 50,
                          left: 20,
                          child: Column(children: [
                            posts.isNotEmpty
                                ? Column(children: [
                                    InkWell(
                                        child: Image.asset(Images.list,
                                            height: 50),
                                        onTap: () {
                                          showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (context) {
                                                return ListPostsDialog(
                                                  posts: posts,
                                                  selectPost: (post) {
                                                    showDialog(
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        builder: (context) {
                                                          return PostInfoDialog(
                                                              post: post);
                                                        });
                                                  },
                                                );
                                              });
                                        }),
                                    Text('List View',
                                        style: TextStyle(
                                            color: Colors.white,
                                            shadows: const [
                                              Shadow(
                                                color: Colors
                                                    .black, // Choose the color of the shadow
                                                blurRadius:
                                                    4.0, // Adjust the blur radius for the shadow effect
                                                offset: Offset(0,
                                                    4.0), // Set the horizontal and vertical offset for the shadow
                                              ),
                                            ],
                                            fontSize: Dimensions.fontSizeLarge,
                                            fontWeight: FontWeight.bold))
                                  ])
                                : Container(),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                            InkWell(
                                child:
                                    Image.asset(Images.bublePost, height: 50),
                                onTap: () {}),
                            Text('Post',
                                style: TextStyle(
                                    color: Colors.white,
                                    shadows: const [
                                      Shadow(
                                        color: Colors
                                            .black, // Choose the color of the shadow
                                        blurRadius:
                                            4.0, // Adjust the blur radius for the shadow effect
                                        offset: Offset(0,
                                            4.0), // Set the horizontal and vertical offset for the shadow
                                      ),
                                    ],
                                    fontSize: Dimensions.fontSizeLarge,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      ]))
                    ]))));
  }

  Future<void> addingMarkersInMap(BuildContext context) async {
    Set<Marker> tempMarkers = {};
    for (PostModel post in posts) {
      if (post.location != null) {
        tempMarkers.add(Marker(
          markerId: MarkerId(const Uuid().v4()),
          position: LatLng(
            post.location!.latitude,
            post.location!.longitude,
          ),
          icon: await getCustomIcon(post),
          onTap: () {
            final commonPosts =
                context.read<CategoryPostsCubit>().postsWithSameLocation(post);
            if (commonPosts.length == 1) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return PostInfoDialog(post: post, chat: getChatForUser(post.userId));
                  });
            } else {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return ListPostsDialog(
                      posts: commonPosts,
                      selectPost: (post) {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return PostInfoDialog(post: post, chat: getChatForUser(post.userId));
                            });
                      },
                    );
                  });
            }
          },
        ));
      }
    }
    setState(() {
      markers = tempMarkers;
    });
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

  Future<BitmapDescriptor> getCustomIcon(PostModel postModel) async {
    return SizedBox(
      height: 125,
      width: 125,
      child: Image.asset(postModel.imageCategory(), fit: BoxFit.contain),
    ).toBitmapDescriptor();
  }
}

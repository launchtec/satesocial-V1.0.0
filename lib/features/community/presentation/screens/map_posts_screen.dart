import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haversine_distance/haversine_distance.dart' as havers;
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/maps_util.dart';
import 'package:sate_social/features/community/domain/use_cases/category_posts_case.dart';
import 'package:sate_social/features/community/presentation/blocks/category_posts/category_posts_cubit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sate_social/features/community/presentation/widgets/list_posts_dialog.dart';
import 'package:sate_social/features/community/presentation/widgets/post_info_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../data/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';
import '../blocks/category_posts/category_posts_state.dart';

class MapPostsScreen extends StatelessWidget {
  final String category;
  const MapPostsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryPostsCubit(
        postsCategoryCase: CategoryPostsCase(
          postRepository: context.read<PostRepository>(),
        ),
      ),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: BlocConsumer<CategoryPostsCubit, CategoryPostsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (markers.isEmpty && state.postModels.isNotEmpty) {
                posts = state.postModels;
                addingMarkersInMap();
              }
              return Container(
                  padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeOverLarge),
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
                                  child: Text(
                                      Get.find<String>(tag: 'city') ?? '',
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
                              state.postModels.isNotEmpty
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
                                                      posts: state.postModels,
                                                      selectPost: (post) {
                                                        showDialog(
                                                            barrierDismissible: true,
                                                            context: context,
                                                            builder: (context) {
                                                              return PostInfoDialog(post: post);
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              fontWeight: FontWeight.bold)
                                      )
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
                      ]));
            }));
  }

  Future<void> addingMarkersInMap() async {
    Set<Marker> tempMarkers = {};
    await updatePostsLocation();
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
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return PostInfoDialog(post: post);
                });
          },
        ));
      }
    }
    setState(() {
      markers = tempMarkers;
    });
  }

  Future<void> updatePostsLocation() async {
    final haversineDistance = havers.HaversineDistance();
    for (PostModel post in posts) {
      if (post.zipCode.isNotEmpty) {
        List<Location> locations =
            await locationFromAddress("USA, ${post.zipCode}");
        if (locations.isNotEmpty) {
          post.location = locations.first;
          if (_position != null) {
            int miDistance = haversineDistance
                .haversine(
                    havers.Location(_position!.latitude, _position!.longitude),
                    havers.Location(
                        post.location!.latitude, post.location!.longitude),
                    havers.Unit.MILE)
                .floor();
            post.strLocation = '$miDistance mi.';
          }
        }
      }
    }
  }

  Future<BitmapDescriptor> getCustomIcon(PostModel postModel) async {
    return SizedBox(
      height: 125,
      width: 125,
      child: Image.asset(postModel.imageCategory(), fit: BoxFit.contain),
    ).toBitmapDescriptor();
  }
}

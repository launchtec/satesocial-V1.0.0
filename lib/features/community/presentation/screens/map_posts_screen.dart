import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sate_social/core/util/maps_util.dart';
import 'package:sate_social/features/community/domain/use_cases/posts_category_case.dart';
import 'package:sate_social/features/community/presentation/blocks/get_posts/get_posts_cubit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sate_social/features/community/presentation/widgets/post_info_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../data/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';
import '../blocks/get_posts/get_posts_state.dart';

class MapPostsScreen extends StatelessWidget {
  const MapPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPostsCubit(
        postsCategoryCase: PostsCategoryCase(
          postRepository: context.read<PostRepository>(),
        ),
      ),
      child: const MapPostsView(),
    );
  }
}

class MapPostsView extends StatefulWidget {
  const MapPostsView({super.key});

  @override
  State<MapPostsView> createState() => _MapPostsViewState();
}

class _MapPostsViewState extends State<MapPostsView> {
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(39.7413907, -104.9982888),
    zoom: 12,
  );

  @override
  void initState() {
    context
        .read<GetPostsCubit>()
        .getCategoryPosts('Professional & Gig Economy');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: BlocConsumer<GetPostsCubit, GetPostsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (markers.isEmpty && state.postModels.isNotEmpty) {
                addingMarkersInMap(state.postModels);
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
                        const Divider(
                            color: Colors.grey,
                            thickness: 5,
                            height: Dimensions.paddingSizeExtraSmall),
                        Expanded(
                            child: Stack(children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
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
                              InkWell(
                                  child: Image.asset(Images.list, height: 50),
                                  onTap: () {}),
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
                                      fontWeight: FontWeight.bold)),
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

  Future<void> addingMarkersInMap(List<PostModel> postModels) async {
    Set<Marker> tempMarkers = {};
    for (PostModel post in postModels) {
      if (post.zipCode.isNotEmpty) {
        List<Location> locations = await locationFromAddress("USA, ${post.zipCode}");
        if (locations.isNotEmpty) {
          tempMarkers.add(Marker(
            markerId: MarkerId(const Uuid().v4()),
            position: LatLng(
              locations.first.latitude,
              locations.first.longitude,
            ),
            icon: await getCustomIcon(),
            onTap: (){
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
    }
    setState(() {
      markers = tempMarkers;
    });
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(Images.marker),
    ).toBitmapDescriptor();
  }
}

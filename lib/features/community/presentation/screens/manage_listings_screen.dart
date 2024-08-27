import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/community/domain/use_cases/delete_post_use_case.dart';
import 'package:sate_social/features/community/domain/use_cases/get_my_posts_case.dart';
import 'package:sate_social/features/community/presentation/blocks/delete_post/delete_post_cubit.dart';
import 'package:sate_social/features/community/presentation/blocks/get_my_posts/get_my_posts_state.dart';
import 'package:sate_social/features/community/presentation/widgets/manage_item_widget.dart';

import '../../../../core/util/dimensions.dart';
import '../../../../core/util/images.dart';
import '../../../../core/util/styles.dart';
import '../../../auth/presentation/blocks/update_activity/update_activity_cubit.dart';
import '../../data/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';
import '../blocks/get_my_posts/get_my_posts_cubit.dart';

class ManageListingsScreen extends StatelessWidget {
  const ManageListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetMyPostsCubit(
                    getMyPostsCase: GetMyPostsCase(
                  postRepository: context.read<PostRepository>(),
                ))..init()),
        BlocProvider(
            create: (context) => DeletePostCubit(
                deletePostUseCase: DeletePostUseCase(
                  postRepository: context.read<PostRepository>(),
                )))
      ],
      child: const ManageListingsView(),
    );
  }
}

class ManageListingsView extends StatefulWidget {
  const ManageListingsView({super.key});

  @override
  State<ManageListingsView> createState() => _ManageListingsViewState();
}

class _ManageListingsViewState extends State<ManageListingsView> {
  List<PostModel> existingPosts = [];
  List<PostModel> pendingPosts = [];
  final ScrollController existingScrollController = ScrollController();
  final ScrollController pendingScrollController = ScrollController();

  @override
  void initState() {
    context.read<UpdateActivityCubit>().updateActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: BlocBuilder<GetMyPostsCubit, GetMyPostsState>(
            builder: (blocContext, state) {
              existingPosts = state.postModels.where((post) => post.isConfirmed).toList();
              pendingPosts = state.postModels.where((post) => !post.isConfirmed).toList();
              return Container(
                  padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeOverLarge),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.backCommunity),
                        fit: BoxFit.cover,
                        opacity: 0.2),
                  ),
                  child: Column(children: [
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
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Center(
                        child: Text('Manage Listings',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.fontSizeOverLarge))),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Column(children: [
                      Container(
                        height: context.height / 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radiusLarge)),
                        ),
                        child: Column(children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Text('Existing Listings',
                              style: TextStyle(
                                  color: Colors.black,
                                  shadows: const [
                                    Shadow(
                                      color: Colors
                                          .white, // Choose the color of the shadow
                                      blurRadius:
                                          4.0, // Adjust the blur radius for the shadow effect
                                      offset: Offset(0,
                                          4.0), // Set the horizontal and vertical offset for the shadow
                                    ),
                                  ],
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeLarge)),
                          Expanded(
                                  child: Scrollbar(
                                      controller: existingScrollController,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          controller: existingScrollController,
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeSmall,
                                              horizontal: Dimensions
                                                  .paddingSizeExtraSmall),
                                          itemCount: existingPosts.length,
                                          itemBuilder: (context, index) {
                                            return ManageItemWidget(
                                              postModel: existingPosts[index],
                                              onDelete: () => showDeletePostDialog(blocContext, existingPosts[index].id),
                                            );
                                          })))
                        ]),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeOverLarge),
                      Container(
                        height: context.height / 3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault),
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radiusLarge)),
                        ),
                        child: Column(children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Text('Pending Listings',
                              style: TextStyle(
                                  color: Colors.black,
                                  shadows: const [
                                    Shadow(
                                      color: Colors
                                          .white, // Choose the color of the shadow
                                      blurRadius:
                                          4.0, // Adjust the blur radius for the shadow effect
                                      offset: Offset(0,
                                          4.0), // Set the horizontal and vertical offset for the shadow
                                    ),
                                  ],
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeLarge)),
                          Expanded(
                              child: Scrollbar(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      controller: ScrollController(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimensions.paddingSizeSmall,
                                          horizontal:
                                              Dimensions.paddingSizeExtraSmall),
                                      itemCount: pendingPosts.length,
                                      itemBuilder: (context, index) {
                                        return ManageItemWidget(
                                            postModel: pendingPosts[index],
                                            onDelete: () => showDeletePostDialog(blocContext, pendingPosts[index].id),
                                            onEdit: () {

                                            },
                                        );
                                      })))
                        ]),
                      ),
                    ])
                  ]));
            }));
  }

  void showDeletePostDialog(BuildContext blocContext, String postId) async {
    showDialog(
        context: blocContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            // <-- SEE HERE
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Are you sure?', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge))
              ]),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(fontSize: Dimensions.fontSizeDefault)),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    blocContext
                        .read<DeletePostCubit>()
                        .deletePost(postId);
                    Navigator.pop(context);
                  },
                  child: Text('Delete', style: TextStyle(fontSize: Dimensions.fontSizeDefault, color: Colors.red)),
                )
              ]),
            ],
          );
        });
  }
}

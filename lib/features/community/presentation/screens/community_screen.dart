import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sate_social/core/util/app_constants.dart';
import 'package:sate_social/core/util/dimensions.dart';
import 'package:sate_social/core/util/styles.dart';
import 'package:sate_social/features/community/presentation/widgets/post_item_widget.dart';

import '../../../../core/route/route_helper.dart';
import '../../../../core/util/images.dart';
import '../../../auth/presentation/blocks/update_activity/update_activity_cubit.dart';
import '../../data/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/use_cases/category_posts_case.dart';
import '../blocks/category_posts/category_posts_cubit.dart';
import '../blocks/category_posts/category_posts_state.dart';
import '../widgets/post_info_dialog.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryPostsCubit(
        postsCategoryCase: CategoryPostsCase(
          postRepository: context.read<PostRepository>(),
        ),
      ),
      child: const CommunityView(),
    );
  }
}

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  String city = '';
  List<PostModel> featurePosts = [];

  @override
  void initState() {
    try {
      city = Get.find<String>(tag: 'city');
    } catch (exception) {}
    context.read<UpdateActivityCubit>().updateActivity();
    context
        .read<CategoryPostsCubit>()
        .getCategoryPosts(AppConstants.postCategories[2]);
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
                    child: Text(city,
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
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox(width: Dimensions.paddingSizeDefault),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                SizedBox(
                    width: context.width / 4,
                    height: context.height / 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text('AD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    )),
                const SizedBox(width: Dimensions.paddingSizeDefault),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Text('Featured Listings',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeExtraLarge))),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              BlocConsumer<CategoryPostsCubit, CategoryPostsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (featurePosts.isEmpty) {
                      featurePosts = state.postModels;
                    }
                    return Expanded(
                        child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radiusLarge)),
                      ),
                      child: !state.isLoading
                          ? ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall,
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              itemCount: featurePosts.length,
                              itemBuilder: (context, index) {
                                return PostItemWidget(
                                  postModel: featurePosts[index],
                                  onTap: () => showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return PostInfoDialog(
                                            post: featurePosts[index]);
                                      }),
                                );
                              })
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.0)),
                    ));
                  }),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bublePost, height: 55),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () =>
                          Get.toNamed(RouteHelper.getCreatePostRoute())),
                  const Text('Post',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  IconButton(
                      icon: Image.asset(Images.bubleMessage, height: 50),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () =>
                          Get.toNamed(RouteHelper.getCommunityChatsRoute())),
                  const Text('Messages',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                Expanded(
                    child: Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bubleActivities,
                          width: context.width / 4),
                      onPressed: () => Get.toNamed(
                          RouteHelper.getMapPostRoute(category: 'social'))),
                  const Text('Activities',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ])),
                Column(children: [
                  IconButton(
                      icon: Image.asset(Images.bubleManage, height: 45),
                      onPressed: () =>
                          Get.toNamed(RouteHelper.getManageListingsRoute())),
                  const Text('Manage\nListings',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ]),
                const SizedBox(width: Dimensions.paddingSizeDefault),
              ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      IconButton(
                          icon: Image.asset(Images.bubleLove,
                              width: context.width / 4),
                          onPressed: () => Get.toNamed(
                              RouteHelper.getMapPostRoute(
                                  category: 'romance'))),
                      const Text('Love',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                    Column(children: [
                      IconButton(
                          icon: Image.asset(Images.bubleGig,
                              width: context.width / 4),
                          onPressed: () => Get.toNamed(
                              RouteHelper.getMapPostRoute(category: 'gig'))),
                      const Text('Gig',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ])
                  ]),
              const SizedBox(height: Dimensions.paddingSizeSmall)
            ])));
  }
}

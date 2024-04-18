import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/category_posts_case.dart';
import 'package:haversine_distance/haversine_distance.dart' as havers;

import 'category_posts_state.dart';

class CategoryPostsCubit extends Cubit<CategoryPostsState> {
  final CategoryPostsCase _postsCategoryCase;

  CategoryPostsCubit({
    required CategoryPostsCase postsCategoryCase,
  }): _postsCategoryCase = postsCategoryCase,
        super(const CategoryPostsState());

  Future<void> getCategoryPosts(String category) async {
    List<PostModel> postModels = await _postsCategoryCase.call(category);
    await updatePostsLocation(postModels);
    emit(CategoryPostsState(isLoading: false, postModels: postModels));
  }

  Future<void> updatePostsLocation(List<PostModel> posts) async {
    try {
      final haversineDistance = havers.HaversineDistance();
      final position = Get.find<Position>(tag: 'coordinates');

      for (PostModel post in posts) {
        if (post.zipCode.isNotEmpty) {
          List<Location> locations =
          await locationFromAddress("USA, ${post.zipCode}");
          if (locations.isNotEmpty) {
            post.location = locations.first;
            int miDistance = haversineDistance
                .haversine(
                havers.Location(position.latitude, position.longitude),
                havers.Location(
                    post.location!.latitude, post.location!.longitude),
                havers.Unit.MILE)
                .floor();
            post.strLocation = '$miDistance mi.';
          }
        }
      }
    } catch (exception) {}
  }

  List<PostModel> postsWithSameLocation(PostModel uniquePost) {
    List<PostModel> oneLocationPosts = [];
    for (PostModel post in state.postModels) {
      if (post.zipCode == uniquePost.zipCode) {
        oneLocationPosts.add(post);
      }
    }
    return oneLocationPosts;
  }
}
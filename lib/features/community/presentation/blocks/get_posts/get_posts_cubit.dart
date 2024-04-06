import 'package:bloc/bloc.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/posts_category_case.dart';
import 'package:sate_social/features/community/presentation/blocks/get_posts/get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  final PostsCategoryCase _postsCategoryCase;

  GetPostsCubit({
    required PostsCategoryCase postsCategoryCase,
  }): _postsCategoryCase = postsCategoryCase,
        super(const GetPostsState());

  Future<void> getCategoryPosts(String category) async {
    List<PostModel> postModels = await _postsCategoryCase.call(category);
    emit(GetPostsState(isLoading: false, postModels: postModels));
  }
}
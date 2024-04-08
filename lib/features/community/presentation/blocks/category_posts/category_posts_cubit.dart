import 'package:bloc/bloc.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/category_posts_case.dart';

import 'category_posts_state.dart';

class CategoryPostsCubit extends Cubit<CategoryPostsState> {
  final CategoryPostsCase _postsCategoryCase;

  CategoryPostsCubit({
    required CategoryPostsCase postsCategoryCase,
  }): _postsCategoryCase = postsCategoryCase,
        super(const CategoryPostsState());

  Future<void> getCategoryPosts(String category) async {
    List<PostModel> postModels = await _postsCategoryCase.call(category);
    emit(CategoryPostsState(isLoading: false, postModels: postModels));
  }
}
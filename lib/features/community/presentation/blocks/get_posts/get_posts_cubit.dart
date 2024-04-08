import 'package:bloc/bloc.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

import '../../../domain/use_cases/get_posts_case.dart';
import 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  final GetPostsCase _getPostsCase;

  GetPostsCubit({
    required GetPostsCase getPostsCase,
  }): _getPostsCase = getPostsCase,
        super(const GetPostsState());

  Future<void> getPosts() async {
    List<PostModel> postModels = await _getPostsCase.call();
    emit(GetPostsState(isLoading: false, postModels: postModels));
  }
}
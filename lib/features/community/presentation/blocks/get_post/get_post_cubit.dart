import 'package:bloc/bloc.dart';
import 'package:sate_social/features/community/domain/use_cases/get_post_case.dart';
import 'package:sate_social/features/community/presentation/blocks/get_post/get_post_state.dart';

import '../../../data/models/post_model.dart';

class GetPostCubit extends Cubit<GetPostState> {
  final GetPostCase _getPostCase;

  GetPostCubit({
    required GetPostCase getPostCase,
  })  : _getPostCase = getPostCase,
        super(const GetPostState());

  Future<void> getPost(String postId) async {
    PostModel postModel = await _getPostCase.call(postId);
    emit(GetPostState(isLoading: false, postModel: postModel));
  }
}

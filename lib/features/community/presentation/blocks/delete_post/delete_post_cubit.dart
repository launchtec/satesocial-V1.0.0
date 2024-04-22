import 'package:bloc/bloc.dart';
import 'package:sate_social/features/community/presentation/blocks/delete_post/delete_post_state.dart';

import '../../../domain/use_cases/delete_post_use_case.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  final DeletePostUseCase _deletePostUseCase;

  DeletePostCubit({
    required DeletePostUseCase deletePostUseCase,
  })  : _deletePostUseCase = deletePostUseCase,
        super(InitialDeletePostState());


  Future<void> deletePost(String postId) async {
    emit(LoadingDeletePostState());
    try {
      await _deletePostUseCase(postId);
      emit(SuccessDeletePostState());
    } catch (err) {
      emit(FailureDeletePostState(err));
    }
  }
}
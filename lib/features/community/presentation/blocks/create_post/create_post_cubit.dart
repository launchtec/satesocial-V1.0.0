import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/add_post_use_case.dart';
import 'package:sate_social/features/community/presentation/blocks/create_post/create_post_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/blocks/form_status.dart';
import '../../../../../core/util/app_constants.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final AddPostUseCase _addPostUseCase;

  CreatePostCubit({
    required AddPostUseCase addPostUseCase,
  })  : _addPostUseCase = addPostUseCase,
        super(const CreatePostState());

  void titleChanged(String title) {
    emit(
      state.copyWith(
        title: title,
      ),
    );
  }

  void contentChanged(String content) {
    emit(
      state.copyWith(
        content: content,
      ),
    );
  }

  void categoryChanged(String category) {
    emit(
      state.copyWith(
        category: category,
      ),
    );
  }

  void groupChanged(String group) {
    emit(
      state.copyWith(
        group: group,
      ),
    );
  }

  void zipCodeChanged(String zipCode) {
    emit(
      state.copyWith(
        zipCode: zipCode,
      ),
    );
  }


  Future<void> submitPost() async {
    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _addPostUseCase(
        PostModel(
            id: Uuid().v4(),
            userId: FirebaseAuth.instance.currentUser!.uid,
            title: state.title ?? '',
            content: state.content ?? '',
            category: state.category ?? AppConstants.postCategories[0],
            group: state.group ?? AppConstants.romanceGroups[0],
            zipCode: state.zipCode ?? '',
            created: DateTime.now().toIso8601String()),
      );
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/add_post_use_case.dart';
import 'package:sate_social/features/community/presentation/blocks/create_post/create_post_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/util/app_constants.dart';
import '../../../domain/use_cases/upload_doc_case.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final AddPostUseCase _addPostUseCase;
  final UploadDocUseCase _uploadDocCase;

  CreatePostCubit({
    required AddPostUseCase addPostUseCase,
    required UploadDocUseCase uploadDocUseCase,
  })  : _addPostUseCase = addPostUseCase, _uploadDocCase = uploadDocUseCase,
        super(const CreatePostState(category: 'Romance Posting', group: 'Couples'));

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

  void rateChanged(String rate) {
    emit(
      state.copyWith(
        rate: rate,
      ),
    );
  }

  void uploadDocChanged(File uploadDoc) {
    emit(
      state.copyWith(
        uploadDoc: uploadDoc,
      ),
    );
  }

  void employmentTypeChanged(String employmentType) {
    emit(
      state.copyWith(
        employmentType: employmentType,
      ),
    );
  }

  bool isRomanticCategory() {
    return state.category == 'Romance Posting';
  }

  bool isSocialCategory() {
    return state.category == 'Social & Activity Posting';
  }

  bool isGigCategory() {
    return state.category == 'Professional & Gig Economy';
  }

  Future<void> submitPost() async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    String? urlDoc;
    if (isGigCategory() && state.uploadDoc != null) {
      urlDoc = await _uploadDocCase.call(state.uploadDoc!.path, basename(state.uploadDoc!.path), FirebaseAuth.instance.currentUser!.uid);
    }
    try {
      await _addPostUseCase(
        PostModel(
            id: const Uuid().v4(),
            userId: FirebaseAuth.instance.currentUser!.uid,
            title: state.title ?? '',
            content: state.content ?? '',
            category: state.category ?? AppConstants.postCategories[0],
            group: state.group ?? AppConstants.romanceGroups[0],
            zipCode: state.zipCode ?? '',
            created: DateTime.now().toIso8601String(),
            rate: state.rate,
            employmentType: state.employmentType,
            urlDoc: urlDoc,
            isConfirmed: false
        ),
      );
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}

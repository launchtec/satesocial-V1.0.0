import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/use_cases/get_my_posts_case.dart';

import 'get_my_posts_state.dart';

class GetMyPostsCubit extends Cubit<GetMyPostsState> {
  StreamSubscription? _myPostsSubscription;
  final GetMyPostsCase _getMyPostsCase;

  GetMyPostsCubit({
    required GetMyPostsCase getMyPostsCase,
  })  : _getMyPostsCase = getMyPostsCase,
        super(const GetMyPostsState());

  Future<void> init() async {
    _myPostsSubscription =
        _getMyPostsCase.call(FirebaseAuth.instance.currentUser!.uid).listen(myPostsListen);
  }

  void myPostsListen(
      Iterable<PostModel> postModels) async {
    emit(GetMyPostsState(
      isLoading: false,
      postModels: postModels,
    ));
  }

  @override
  Future<void> close() {
    _myPostsSubscription?.cancel();
    return super.close();
  }
}

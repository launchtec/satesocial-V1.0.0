import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/use_cases/user_info_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_info/user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final UserInfoCase _userInfoCase;

  UserInfoCubit({
    required UserInfoCase userInfoCase,
  })  : _userInfoCase = userInfoCase,
        super(const UserInfoState());

  Future<AppUser> getUserInfo() async {
    emit(const UserInfoState(isLoading: true));
    AppUser appUser = await _userInfoCase.call(FirebaseAuth.instance.currentUser!.uid);
    emit(UserInfoState(isLoading: false, user: appUser));
    return appUser;
  }
}

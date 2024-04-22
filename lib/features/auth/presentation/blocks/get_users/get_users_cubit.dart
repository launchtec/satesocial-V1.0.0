import 'package:bloc/bloc.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/use_cases/get_users_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/get_users/get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  final GetUsersCase _getUsersCase;

  GetUsersCubit({
    required GetUsersCase getUsersCase,
  }): _getUsersCase = getUsersCase,
        super(const GetUsersState());

  Future<void> getUsers() async {
    List<AppUser> users = await _getUsersCase.call();
    emit(GetUsersState(isLoading: false, users: users));
  }
}
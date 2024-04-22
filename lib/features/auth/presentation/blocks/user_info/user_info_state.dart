import 'package:equatable/equatable.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';

class UserInfoState extends Equatable {
  final bool isLoading;
  final AppUser? user;

  const UserInfoState({
    this.isLoading = true,
    this.user,
  });

  @override
  List<Object?> get props => [isLoading, user];
}
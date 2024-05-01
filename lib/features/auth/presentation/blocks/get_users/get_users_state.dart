import 'package:equatable/equatable.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';

class GetUsersState extends Equatable {
  final bool isLoading;
  final List<AppUser> users;

  const GetUsersState({
    this.isLoading = true,
    this.users = const [],
  });

  @override
  List<Object?> get props => [isLoading, users];
}
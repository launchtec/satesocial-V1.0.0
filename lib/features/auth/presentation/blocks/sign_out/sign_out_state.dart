import 'package:equatable/equatable.dart';

abstract class SignOutState extends Equatable {}

class InitialSignOutState extends SignOutState {
  InitialSignOutState();

  @override
  List get props => [];
}

class LoadingSignOutState extends SignOutState {
  @override
  List get props => [];
}

class SuccessSignOutState extends SignOutState {
  @override
  List get props => [];
}

class FailureSignOutState<String> extends SignOutState {
  final String? error;
  FailureSignOutState(
      this.error,
      );

  @override
  List<String> get props => error != null ? [error!] : [];
}
import 'package:equatable/equatable.dart';

abstract class DeletePostState extends Equatable {}

class InitialDeletePostState extends DeletePostState {
  InitialDeletePostState();

  @override
  List get props => [];
}

class LoadingDeletePostState extends DeletePostState {
  @override
  List get props => [];
}

class SuccessDeletePostState extends DeletePostState {
  @override
  List get props => [];
}

class FailureDeletePostState<String> extends DeletePostState {
  final String? error;
  FailureDeletePostState(
      this.error,
      );

  @override
  List<String> get props => error != null ? [error!] : [];
}
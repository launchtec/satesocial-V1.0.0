import 'package:equatable/equatable.dart';

abstract class PurchasePostState extends Equatable {
  const PurchasePostState();

  @override
  List<Object> get props => [];
}

class PurchasePostInitial extends PurchasePostState {}

class PurchasePostLoading extends PurchasePostState {}

class PurchasePostSuccess extends PurchasePostState {}

class PurchasePostFailure extends PurchasePostState {
  final String error;

  const PurchasePostFailure(this.error);

  @override
  List<Object> get props => [error];
}
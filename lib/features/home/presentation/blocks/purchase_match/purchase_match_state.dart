import 'package:equatable/equatable.dart';

abstract class PurchaseMatchState extends Equatable {
  const PurchaseMatchState();

  @override
  List<Object> get props => [];
}

class PurchaseMatchInitial extends PurchaseMatchState {}

class PurchaseMatchLoading extends PurchaseMatchState {}

class PurchaseMatchSuccess extends PurchaseMatchState {}

class PurchaseMatchFailure extends PurchaseMatchState {
  final String error;

  const PurchaseMatchFailure(this.error);

  @override
  List<Object> get props => [error];
}
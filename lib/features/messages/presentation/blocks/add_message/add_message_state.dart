import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class AddMessageState extends Equatable {
  final RequestStatus requestStatus;

  const AddMessageState({
    this.requestStatus = RequestStatus.initial,
  });

  AddMessageState copyWith({
    RequestStatus? requestStatus,
  }) {
    return AddMessageState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
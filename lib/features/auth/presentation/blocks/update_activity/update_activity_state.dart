import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class UpdateActivityState extends Equatable {
  final RequestStatus requestStatus;

  const UpdateActivityState({
    this.requestStatus = RequestStatus.initial,
  });

  UpdateActivityState copyWith({
    RequestStatus? requestStatus,
  }) {
    return UpdateActivityState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
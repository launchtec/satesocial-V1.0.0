import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class UpdateLocationState extends Equatable {
  final RequestStatus requestStatus;

  const UpdateLocationState({
    this.requestStatus = RequestStatus.initial,
  });

  UpdateLocationState copyWith({
    RequestStatus? requestStatus,
  }) {
    return UpdateLocationState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
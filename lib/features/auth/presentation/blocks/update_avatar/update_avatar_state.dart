import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class UpdateAvatarState extends Equatable {
  final RequestStatus requestStatus;

  const UpdateAvatarState({
    this.requestStatus = RequestStatus.initial,
  });

  UpdateAvatarState copyWith({
    RequestStatus? requestStatus,
  }) {
    return UpdateAvatarState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
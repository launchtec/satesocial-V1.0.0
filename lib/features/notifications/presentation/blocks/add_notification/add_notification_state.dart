import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class AddNotificationState extends Equatable {
  final RequestStatus requestStatus;

  const AddNotificationState({
    this.requestStatus = RequestStatus.initial,
  });

  AddNotificationState copyWith({
    RequestStatus? requestStatus,
  }) {
    return AddNotificationState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
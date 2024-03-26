import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class ReadNotificationState extends Equatable {
  final RequestStatus requestStatus;

  const ReadNotificationState({
    this.requestStatus = RequestStatus.initial,
  });

  ReadNotificationState copyWith({
    RequestStatus? requestStatus,
  }) {
    return ReadNotificationState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
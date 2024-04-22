import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class AddChatConnectState extends Equatable {
  final RequestStatus requestStatus;

  const AddChatConnectState({
    this.requestStatus = RequestStatus.initial,
  });

  AddChatConnectState copyWith({
    RequestStatus? requestStatus,
  }) {
    return AddChatConnectState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
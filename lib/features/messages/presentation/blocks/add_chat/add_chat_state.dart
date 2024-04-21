import 'package:equatable/equatable.dart';

import '../../../../../core/data/blocks/request_status.dart';

class AddChatState extends Equatable {
  final RequestStatus requestStatus;

  const AddChatState({
    this.requestStatus = RequestStatus.initial,
  });

  AddChatState copyWith({
    RequestStatus? requestStatus,
  }) {
    return AddChatState(
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object?> get props => [requestStatus];
}
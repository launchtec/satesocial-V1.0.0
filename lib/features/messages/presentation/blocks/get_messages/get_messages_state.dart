import 'package:equatable/equatable.dart';
import 'package:sate_social/features/messages/data/models/message.dart';

class GetMessagesState extends Equatable {
  final bool isLoading;
  final Iterable<Message> messages;

  const GetMessagesState({
    this.isLoading = true,
    this.messages = const [],
  });

  @override
  List<Object?> get props => [isLoading, messages];
}
import 'package:equatable/equatable.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';

class GetChatsState extends Equatable {
  final bool isLoading;
  final Iterable<Chat> chats;

  const GetChatsState({
    this.isLoading = true,
    this.chats = const [],
  });

  @override
  List<Object?> get props => [isLoading, chats];
}
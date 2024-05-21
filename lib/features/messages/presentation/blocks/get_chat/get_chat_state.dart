import 'package:equatable/equatable.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';

class GetChatState extends Equatable {
  final bool isLoading;
  final Chat? chat;

  const GetChatState({
    this.isLoading = true,
    this.chat,
  });

  @override
  List<Object?> get props => [isLoading, chat];
}
import 'package:equatable/equatable.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';

class Chat extends Equatable {
  final String id;
  final String name;
  final String senderId;
  final String receiverId;
  final AppUser? sender;
  final AppUser? receiver;
  final PostInfo? postInfo;
  final String? connectId;

  const Chat({
    required this.id,
    required this.name,
    required this.senderId,
    required this.receiverId,
    this.sender,
    this.receiver,
    this.postInfo,
    this.connectId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'senderId': senderId,
      'receiverId': receiverId,
      'postInfo': postInfo?.toMap(),
      'connectId': connectId
    };
  }

  Map<String, dynamic> toMapJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'senderId': senderId,
      'receiverId': receiverId,
      'sender': sender?.toMap(),
      'receiver': receiver?.toMap(),
      'postInfo': postInfo?.toMap(),
      'connectId': connectId
    };
  }

  static Chat fromMap(Map<String, dynamic> json) {
    return Chat(
        id: json['id'],
        name: json['name'],
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        sender: AppUser.fromMap(json['sender']),
        receiver: AppUser.fromMap(json['receiver']),
        postInfo: PostInfo.fromMap(json['postInfo'])
    );
  }

  @override
  List<Object?> get props => [id, name, senderId, receiverId, postInfo, connectId];
}

class PostInfo extends Equatable {
  final String id;
  final String title;
  final String category;
  final String created;

  const PostInfo({
    required this.id,
    required this.title,
    required this.category,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'created': created,
    };
  }

  static PostInfo fromMap(Map<String, dynamic> mapPostInfo) {
    return PostInfo(
        id: mapPostInfo['id'] ?? '',
        title: mapPostInfo['title'] ?? '',
        category: mapPostInfo['category'] ?? '',
        created: mapPostInfo['created'] ?? ''
    );
  }

  @override
  List<Object?> get props =>
      [id, title, category, created];
}
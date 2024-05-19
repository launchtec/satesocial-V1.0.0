class AvatarUser {
  final String avatar;
  final String lastActivity;

  const AvatarUser({
    required this.avatar,
    required this.lastActivity
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarMap': avatar,
      'lastActivity': lastActivity
    };
  }
}
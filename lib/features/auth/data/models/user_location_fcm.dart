class UserLocationFcm {
  final double latitude;
  final double longitude;
  final String fcmToken;
  final String lastActivity;

  const UserLocationFcm({
    required this.latitude,
    required this.longitude,
    required this.fcmToken,
    required this.lastActivity
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'fcmToken': fcmToken,
      'lastActivity': lastActivity
    };
  }
}
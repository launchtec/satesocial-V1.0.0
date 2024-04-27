class UserLocationFcm {
  final double latitude;
  final double longitude;
  final String fcmToken;

  const UserLocationFcm({
    required this.latitude,
    required this.longitude,
    required this.fcmToken
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'fcmToken': fcmToken,
    };
  }
}
class UserLocation {
  final double latitude;
  final double longitude;

  const UserLocation({
    required this.latitude,
    required this.longitude
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
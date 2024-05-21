import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final currentPosition = await Geolocator.getCurrentPosition();
    String? city = await cityFromPosition(currentPosition);
    Get.put<Position>(tag: 'coordinates', currentPosition);
    if (city != null) {
      Get.put<String>(tag: 'city', city);
    }

    return currentPosition;
  }

  Future<String?> cityFromPosition(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city;
    if (placemarks.isNotEmpty) {
      city = placemarks.first.locality;
    }
    return city;
  }
}
import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position?> getUserCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // Permission Denied Message
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        print("permission is denied !");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("permission is denied forever !");

      return false;
    } else {
      return true;
    }
  }

}

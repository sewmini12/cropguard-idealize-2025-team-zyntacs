import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static const String _locationKey = 'saved_location';
  static const String _latitudeKey = 'saved_latitude';
  static const String _longitudeKey = 'saved_longitude';

  /// Check location permissions and request if necessary
  static Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current position
  static Future<Position?> getCurrentPosition() async {
    try {
      if (await checkLocationPermission()) {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
      }
    } catch (e) {
      print('Error getting current position: $e');
    }
    return null;
  }

  /// Save location to preferences
  static Future<void> saveLocation(
      String locationName, double? latitude, double? longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_locationKey, locationName);
    if (latitude != null) await prefs.setDouble(_latitudeKey, latitude);
    if (longitude != null) await prefs.setDouble(_longitudeKey, longitude);
  }

  /// Get saved location from preferences
  static Future<Map<String, dynamic>?> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationName = prefs.getString(_locationKey);
    final latitude = prefs.getDouble(_latitudeKey);
    final longitude = prefs.getDouble(_longitudeKey);

    if (locationName != null) {
      return {
        'name': locationName,
        'latitude': latitude,
        'longitude': longitude,
      };
    }
    return null;
  }

  /// Calculate distance between two points
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  /// Get location name from coordinates (simplified version)
  static String getLocationName(double latitude, double longitude) {
    // For now, return coordinates as string
    // In a real app, you would use a reverse geocoding service
    return '${latitude.toStringAsFixed(2)}, ${longitude.toStringAsFixed(2)}';
  }
}

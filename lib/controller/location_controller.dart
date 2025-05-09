import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view/screens/registration_screens/login_screen.dart';

class LocationController extends ChangeNotifier {
  bool _isLocationGranted = false;

  bool get isLocationGranted => _isLocationGranted;

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      _isLocationGranted = false;
      notifyListeners();
      _showPermissionDeniedDialog(context);
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _isLocationGranted = true;
      notifyListeners();
    }

    // If permission is granted, ensure location services are enabled
    if (_isLocationGranted) {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        await Geolocator.openLocationSettings();
        _waitForLocationEnabled(context); // Wait for user to enable location
      } else {
        _navigateToLogin(
            context); // Navigate immediately if location is enabled
      }
    }
  }

  void _waitForLocationEnabled(BuildContext context) async {
    while (!(await Geolocator.isLocationServiceEnabled())) {
      await Future.delayed(const Duration(seconds: 1)); // Check every second
    }
    _navigateToLogin(context);
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text(
            "This app requires location permission to function properly. Please grant permission in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  LatLng? selectedLocation;


  void setSelectedLocation(LatLng location) {
    selectedLocation = location;
    _fetchLocationName(location.latitude, location.longitude);
    latitudeController.text = location.latitude.toString();
    longitudeController.text = location.longitude.toString();

    notifyListeners();
  }


  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();



  String locationName = "current location";
  bool isLoading = false;


  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      Position position = await _determinePosition();
      selectedLocation = LatLng(position.latitude, position.longitude);
      _fetchLocationName(position.latitude, position.longitude);
    } catch (error) {
      print("Error determining position: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> _fetchLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        locationName =
        "${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}";
      } else {
        locationName = "Unknown Location";
      }
    } catch (e) {
      locationName = "Error fetching location: ${e.toString()}";
    }
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }
}

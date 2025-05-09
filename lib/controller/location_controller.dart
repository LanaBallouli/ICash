import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends ChangeNotifier {
  bool isLocationGranted = false;
  LatLng? selectedLocation;
  String locationName = "current location";
  bool isLoading = false;
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();



  void setSelectedLocation(LatLng location) {
    selectedLocation = location;
    _fetchLocationName(location.latitude, location.longitude);
    latitudeController.text = location.latitude.toString();
    longitudeController.text = location.longitude.toString();

    notifyListeners();
  }

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

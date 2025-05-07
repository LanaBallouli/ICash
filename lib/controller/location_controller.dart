import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/address.dart';
import '../model/region.dart';
import '../view/screens/registration_screens/login_screen.dart';

class LocationController extends ChangeNotifier {
  bool isLocationGranted = false;

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        isLocationGranted = false;
        notifyListeners();
        _showPermissionDeniedDialog(context);
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        isLocationGranted = true;
        notifyListeners();
      }

      if (isLocationGranted) {
        bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isLocationEnabled) {
          await Geolocator.openLocationSettings();
          _waitForLocationEnabled(context);
        } else {
          _navigateToLogin(context);
        }
      }
    } catch (e) {
      print("Error requesting location permission: $e");
      _showPermissionDeniedDialog(context);
    }
  }

  void _waitForLocationEnabled(BuildContext context) async {
    final locationServiceStream = Geolocator.getServiceStatusStream();
    await for (final status in locationServiceStream) {
      if (status == ServiceStatus.enabled) {
        _navigateToLogin(context);
        break;
      }
    }
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  LatLng? _selectedLocation;

  LatLng? get selectedLocation => _selectedLocation;

  void setSelectedLocation(LatLng? location) {
    if (location != null) {
      _selectedLocation = location;
      notifyListeners();
    }
  }

  final List<Address> _savedAddresses = [];

  List<Address> get savedAddresses => _savedAddresses;

  TextEditingController streetController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController regionNameController = TextEditingController();
  TextEditingController additionalDirectionsController =
  TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  bool validateFields() {
    return streetController.text.isNotEmpty &&
        buildingNumberController.text.isNotEmpty &&
        regionNameController.text.isNotEmpty &&
        additionalDirectionsController.text.isNotEmpty &&
        double.tryParse(latitudeController.text) != null &&
        double.tryParse(longitudeController.text) != null;
  }

  void addAddress({
    required String? street,
    required int? buildingNumber,
    required Region? regionName,
    required String? additionalDirections,
    required double? latitude,
    required double? longitude,
  }) {
    _savedAddresses.add(
      Address(
        street: street,
        buildingNumber: buildingNumber,
        regionName: regionName,
        additionalDirections: additionalDirections,
        latitude: latitude,
        longitude: longitude,
      ),
    );
    notifyListeners();
  }

  void clearAddresses() {
    _savedAddresses.clear();
    notifyListeners();
  }

  bool hasSavedAddresses() {
    return _savedAddresses.isNotEmpty;
  }

  bool saveCurrentAddress(String areaName, LatLng location) {
    if (!validateFields()) {
      return false;
    }
    addAddress(
      longitude: location.longitude,
      additionalDirections: additionalDirectionsController.text,
      buildingNumber: int.tryParse(buildingNumberController.text),
      latitude: location.latitude,
      regionName: Region(name: regionNameController.text),
      street: streetController.text,
    );
    clearControllers();
    return true;
  }

  void clearControllers() {
    streetController.clear();
    buildingNumberController.clear();
    regionNameController.clear();
    additionalDirectionsController.clear();
    latitudeController.clear();
    longitudeController.clear();
    notifyListeners();
  }
}
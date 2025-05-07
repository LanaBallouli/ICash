import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:test_sales/view/screens/management_screens/client/add_client_screen.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/location_controller.dart';
import '../../../../l10n/app_localizations.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;
  String _locationName = "current location";

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
      _moveCameraToPosition(_selectedLocation!);
      _fetchLocationName(position.latitude, position.longitude);
    }).catchError((error) {
      print("Error determining position: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _selectedLocation == null
                ? CameraPosition(
                    target: LatLng(31.985934703432616, 35.900362288558114),
                    zoom: 14)
                : CameraPosition(target: _selectedLocation!, zoom: 14),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              if (_selectedLocation != null) {
                _moveCameraToPosition(_selectedLocation!);
              }
            },
            onCameraMove: (CameraPosition position) {
              setState(() {
                _selectedLocation = position.target;
              });
              _fetchLocationName(
                  position.target.latitude, position.target.longitude);
            },
          ),
          Center(
            child: Icon(Icons.location_on, color: Colors.red, size: 40.sp),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200.h,
                width: 345.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 23.0,
                        top: 24,
                        right: 23,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.find_location,
                        style: AppStyles.getFontStyle(
                          langController,
                          fontSize: 12.sp,
                          color: Color(0xFF878787),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.pin_drop_outlined,
                        color: AppConstants.primaryColor2,
                      ),
                      title: Text(
                        _locationName,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Center(
                      child: SizedBox(
                        height: 60.h,
                        width: 300.w,
                        child: ElevatedButton(
                          onPressed: _selectedLocation == null
                              ? null
                              : () {
                                  Provider.of<LocationController>(context,
                                          listen: false)
                                      .setSelectedLocation(_selectedLocation!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddClientScreen(),
                                      settings: RouteSettings(
                                          arguments: _selectedLocation),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.set_location,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _moveCameraToPosition(LatLng position) async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(position, 14),
    );
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

  Future<void> _fetchLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          _locationName =
              "${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}";
        });
      } else {
        setState(() {
          _locationName = "Unknown Location";
        });
      }
    } catch (e) {
      setState(() {
        _locationName = "Error fetching location";
      });
    }
  }
}

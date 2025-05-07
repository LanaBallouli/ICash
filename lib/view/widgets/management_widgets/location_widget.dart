import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

import '../../../app_constants.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/location_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../custom_button_widget.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Set<Marker> markers = {};
  String _areaName = "Unknown Area";
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  void _loadSavedLocation() {
    final savedLocation = Provider.of<LocationController>(
      context,
      listen: false,
    ).selectedLocation;

    if (savedLocation != null) {
      setState(() {
        _selectedLocation = savedLocation;
        markers.add(
          Marker(
            markerId: MarkerId('saved_location'),
            position: savedLocation,
            infoWindow: InfoWindow(title: "Selected Location"),
          ),
        );
      });

      _fetchAreaName(savedLocation.latitude, savedLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    final locationController = Provider.of<LocationController>(context);

    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              width: double.infinity,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation ??
                      LatLng(31.985934703432616, 35.900362288558114),
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  final savedLocation = Provider.of<LocationController>(
                    context,
                    listen: false,
                  ).selectedLocation;
                  if (savedLocation != null) {}
                },
                onCameraIdle: () {
                  _fetchAreaNameFromMap();
                },
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 90.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color:Colors.black12,
                ),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Icon(Icons.location_pin, color: Colors.grey),
                title: Text(AppLocalizations.of(context)!.address),
                subtitle: Text(_areaName),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.change,
                    style: AppStyles.getFontStyle(
                      langController,
                      color: AppConstants.primaryColor2,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );
  }

  Future<void> _fetchAreaName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          _areaName =
              "${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}";
        });
      } else {
        setState(() {
          _areaName = "Unknown Area";
        });
      }
    } catch (e) {
      setState(() {
        _areaName = "Error fetching area";
      });
    }
  }

  void _fetchAreaNameFromMap() {
    final visibleRegionCenter =
        _selectedLocation ?? LatLng(31.985934703432616, 35.900362288558114);
    _fetchAreaName(visibleRegionCenter.latitude, visibleRegionCenter.longitude);
  }
}

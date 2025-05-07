import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/model/region.dart';

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
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
                target: LatLng(31.985934703432616, 35.900362288558114),
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
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDarkMode ? Colors.grey : Colors.black12,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
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
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          CustomButtonWidget(
            title: AppLocalizations.of(context)!.save,
            colors: [AppConstants.buttonColor, AppConstants.buttonColor],
            titleColor: Theme.of(context).scaffoldBackgroundColor,
            width: double.infinity,
            borderRadius: 12.r,
            height: 60.h,
            onPressed: () {
              if (locationController.streetController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      content: Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!.fill_all_fields,
                        style: AppStyles.getFontStyle(
                          langController,
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      actions: [
                        CustomButtonWidget(
                          title: AppLocalizations.of(context)!.ok,
                          colors: [
                            AppConstants.buttonColor,
                            AppConstants.buttonColor,
                          ],
                          height: 60.h,
                          borderRadius: 12.r,
                          titleColor: Theme.of(context).scaffoldBackgroundColor,
                          width: 300.w,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                locationController.addAddress(
                    street: locationController.streetController.text,
                    regionName: Region(
                        name: locationController.regionNameController.text),
                    latitude: double.tryParse(
                        locationController.latitudeController.text),
                    longitude: double.tryParse(
                        locationController.longitudeController.text),
                    buildingNumber: int.tryParse(
                        locationController.buildingNumberController.text),
                    additionalDirections:
                        locationController.additionalDirectionsController.text);
              }
            },
          ),
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
              "${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}";
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

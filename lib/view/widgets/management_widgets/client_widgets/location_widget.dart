import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../l10n/app_localizations.dart';

class LocationWidget extends StatefulWidget {
  final LatLng location;
  final bool isAddition;

  const LocationWidget({
    super.key,
    required this.location,
    required this.isAddition,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Set<Marker> markers = {};
  String _areaName = "Unknown Area";
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() {
    // Initialize the selected location with the provided coordinates
    _selectedLocation = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('initial_location'),
          position: _selectedLocation,
          infoWindow: InfoWindow(title: "Selected Location"),
        ),
      );
    });

    _fetchAreaName(_selectedLocation.latitude, _selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: GoogleMap(
              myLocationEnabled: true,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController controller) {},
              onTap: null,
              onCameraIdle: () {
                if (_selectedLocation != null) {
                  _fetchAreaName(_selectedLocation.latitude, _selectedLocation.longitude);
                }
              },
            ),
          ),
          SizedBox(height: 16.h),
          if (widget.isAddition) ...[
            Container(
              height: 90.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppConstants.buttonColor),
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
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
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
        _areaName = "Error fetching area: ${e.toString()}";
      });
    }
  }
}
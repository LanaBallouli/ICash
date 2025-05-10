import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/screens/management_screens/client/update_client_details_screen.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/location_controller.dart';
import '../../../../l10n/app_localizations.dart';
import 'add_client_screen.dart';

class SetLocationScreen extends StatefulWidget {
  final bool isEditMode;
  final LatLng? initialLocation;
  final void Function()? onPressed;
  final Client? client;
  final int? index;

  const SetLocationScreen(
      {super.key,
      this.isEditMode = false,
      this.initialLocation,
      this.onPressed,
      this.client,
      this.index});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationController =
          Provider.of<LocationController>(context, listen: false);

      if (widget.isEditMode && widget.initialLocation != null) {
        locationController.setSelectedLocation(widget.initialLocation!);
      } else {
        locationController.resetSelectedLocation();
        locationController.fetchCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Consumer<LocationController>(
      builder: (context, locationController, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: locationController.isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: locationController.selectedLocation ??
                            LatLng(31.985934703432616, 35.900362288558114),
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                        if (locationController.selectedLocation != null) {
                          _moveCameraToLocation(
                              locationController.selectedLocation!);
                        }
                      },
                      onCameraIdle: () {
                        if (locationController.selectedLocation != null) {
                          locationController.setSelectedLocation(
                              locationController.selectedLocation!);
                        }
                      },
                      onCameraMove: (CameraPosition position) {
                        locationController.setSelectedLocation(position.target);
                      },
                    ),
                    Center(
                      child: Icon(Icons.location_on,
                          color: Colors.red, size: 40.sp),
                    ),
                    _buildBottomSheet(
                        context, langController, locationController),
                    _buildAppBar(context),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, LangController langController,
      LocationController locationController) {
    return Padding(
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
                padding: const EdgeInsets.only(left: 23.0, top: 24, right: 23),
                child: Text(
                  AppLocalizations.of(context)!.current_location,
                  style: AppStyles.getFontStyle(
                    langController,
                    fontSize: 12.sp,
                    color: Color(0xFF878787),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.pin_drop_outlined,
                    color: AppConstants.primaryColor2),
                title: Text(
                  locationController.locationName,
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
                    onPressed: locationController.selectedLocation == null &&
                            !widget.isEditMode
                        ? null
                        : _navigateToNextScreen,
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
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
    );
  }

  void _navigateToNextScreen() {
    final locationController = Provider.of<LocationController>(context, listen: false);
    if (widget.isEditMode) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateClientDetailsScreen(
            client: widget.client!,
            index: widget.index!,
            location: locationController.selectedLocation!,
          ),
        ),
      );
    } else {
      if (locationController.selectedLocation != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddClientScreen(
              location: locationController.selectedLocation!,
            ),
          ),
        );
      }
    }
  }

  Future<void> _moveCameraToLocation(LatLng location) async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(location, 14),
    );
  }
}

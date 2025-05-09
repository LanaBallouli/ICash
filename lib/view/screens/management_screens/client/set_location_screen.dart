import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/location_controller.dart';
import '../../../../l10n/app_localizations.dart';
import 'add_client_screen.dart';

class SetLocationScreen extends StatelessWidget {
  const SetLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Consumer<LocationController>(
      builder: (context, locationController, child) {
        if (!locationController.isLoading && locationController.selectedLocation == null) {
          locationController.fetchCurrentLocation();
        }

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
                  if (locationController.selectedLocation != null) {
                    controller.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        locationController.selectedLocation!,
                        14,
                      ),
                    );
                  }
                },
                onCameraIdle: () {
                  if (locationController.selectedLocation != null) {
                    locationController.setSelectedLocation(locationController.selectedLocation!);
                  }
                },
                onCameraMove: (CameraPosition position) {
                  locationController.setSelectedLocation(position.target);
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
                          leading: Icon(
                            Icons.pin_drop_outlined,
                            color: AppConstants.primaryColor2,
                          ),
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
                              onPressed: locationController.selectedLocation == null
                                  ? null
                                  : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddClientScreen(
                                      location: locationController.selectedLocation!,
                                    ),
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
      },
    );
  }
}
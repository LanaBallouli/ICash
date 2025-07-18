import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/address_controller.dart';
import 'package:test_sales/controller/camera_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/location_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/client_widgets/location_widget.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../widgets/main_widgets/custom_button_widget.dart';
import '../../../widgets/management_widgets/client_widgets/upload_photos.dart';

class AddClientScreen extends StatelessWidget {
  final LatLng location;

  const AddClientScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    final clientController = Provider.of<ClientsController>(context);
    final cameraController =
        Provider.of<CameraController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.add_client,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            clientController.clearClientFields();
            clientController.clearErrors();
            cameraController.clearImages('id');
            cameraController.clearImages('commercial_registration');
            cameraController.clearImages('profession_license');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Consumer<ClientsController>(
            builder: (context, clientsController, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  LocationWidget(
                    location: location,
                    isAddition: true,
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.add_client_prompt,
                      style: AppStyles.getFontStyle(
                        langController,
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ManagementInputWidget(
                    hintText:
                        AppLocalizations.of(context)!.enter_client_trade_name,
                    controller: clientsController.clientNameController,
                    title: AppLocalizations.of(context)!.trade_name,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'tradeName', value: value),
                    errorText: clientsController.errors['tradeName'],
                  ),
                  ManagementInputWidget(
                    hintText:
                        AppLocalizations.of(context)!.enter_person_in_charge,
                    controller:
                        clientsController.clientPersonInChargeController,
                    title: AppLocalizations.of(context)!.person_in_charge,
                    onChanged: (value) => clientsController.validateField(
                        context: context,
                        field: 'personInCharge',
                        value: value),
                    errorText: clientsController.errors['personInCharge'],
                    keyboardType: TextInputType.name,
                  ),
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_client_phone,
                    controller: clientsController.clientPhoneController,
                    title: AppLocalizations.of(context)!.phone,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'phone', value: value),
                    errorText: clientsController.errors['phone'],
                    keyboardType: TextInputType.phone,
                  ),
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_street,
                    controller: clientsController.clientStreetController,
                    title: AppLocalizations.of(context)!.street,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'street', value: value),
                    errorText: clientsController.errors['street'],
                  ),
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_building_num,
                    controller: clientsController.clientBuildingNumController,
                    title: AppLocalizations.of(context)!.building_num,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'buildingNum', value: value),
                    errorText: clientsController.errors['buildingNum'],
                  ),
                  RegionInputWidget(
                    selectedRegion: clientsController.clientSelectedRegion,
                    hintText: AppLocalizations.of(context)!.choose_region,
                    regions: AppConstants.getRegions(context),
                    onChange: (value) =>
                        clientsController.setClientSelectedRegion(value, context),
                    err: clientsController.errors['region'],
                  ),
                  ManagementInputWidget(
                    hintText:
                        AppLocalizations.of(context)!.enter_additional_info,
                    controller:
                        clientsController.clientAdditionalInfoController,
                    title: AppLocalizations.of(context)!.additional_info,
                    keyboardType: TextInputType.text,
                    errorText: null,
                    onChanged: (value) {},
                  ),
                  TypeInputWidget(
                    hintText: AppLocalizations.of(context)!.choose_client_type,
                    typeOptions: [
                      AppLocalizations.of(context)!.cash,
                      AppLocalizations.of(context)!.debt,
                    ],
                    selectedType: validateSelectedType(
                      clientsController.clientSelectedType,
                      [
                        AppLocalizations.of(context)!.cash,
                        AppLocalizations.of(context)!.debt,
                      ],
                    ),
                    onChange: (value) {
                      clientsController.setClientSelectedType(value, context);
                    },
                    err: clientsController.errors['type'],
                  ),
                  if (clientsController.clientSelectedType ==
                      AppLocalizations.of(context)!.debt) ...[
                    SizedBox(
                      height: 15.h,
                    ),
                    UploadPhotos(
                      title: AppLocalizations.of(context)!.client_id,
                      photoType: "id",
                    ),
                    if (clientsController.errors['id_photos'] != null)
                      Text(
                        clientsController.errors['id_photos']!,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    SizedBox(
                      height: 15.h,
                    ),
                    UploadPhotos(
                      title:
                          AppLocalizations.of(context)!.commercial_registration,
                      photoType: "commercial_registration",
                    ),
                    if (clientsController
                            .errors['commercial_registration_photos'] !=
                        null)
                      Text(
                        clientsController
                            .errors['commercial_registration_photos']!,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    SizedBox(
                      height: 15.h,
                    ),
                    UploadPhotos(
                      title: AppLocalizations.of(context)!.profession_license,
                      photoType: "profession_license",
                    ),
                    if (clientsController.errors['profession_license_photos'] !=
                        null)
                      Text(
                        clientsController.errors['profession_license_photos']!,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                  ],
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.add_notes,
                    controller: clientsController.clientNotesController,
                    title: AppLocalizations.of(context)!.notes,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    errorText: null,
                    height: 100.h,
                    maxLines: 3,
                  ),
                  SizedBox(height: 30.h),
                  _buildButtonsRow(context),
                  SizedBox(height: 30.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Consumer3<ClientsController, LocationController,
              CameraController>(
            builder: (context, clientsController, locationController,
                cameraController, child) {
              return CustomButtonWidget(
                title: AppLocalizations.of(context)!.save,
                color:AppConstants.primaryColor2,
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () async {
                  print("Debug: Validating form with the following inputs:");
                  print(
                      "tradeName: ${clientsController.clientNameController.text}");
                  print(
                      "personInCharge: ${clientsController.clientPersonInChargeController.text}");
                  print(
                      "phone: ${clientsController.clientPhoneController.text}");
                  print(
                      "street: ${clientsController.clientStreetController.text}");
                  print(
                      "buildingNum: ${clientsController.clientBuildingNumController.text}");
                  print("Type: ${clientsController.clientSelectedType}");
                  print("Region: ${clientsController.clientSelectedRegion}");

                  clientsController.validateForm(
                      context: context,
                      tradeName: clientsController.clientNameController.text,
                      personInCharge:
                          clientsController.clientPersonInChargeController.text,
                      phone: clientsController.clientPhoneController.text,
                      street: clientsController.clientStreetController.text,
                      buildingNum: int.tryParse(
                          clientsController.clientBuildingNumController.text),
                      region: clientsController.clientSelectedRegion,
                      type: clientsController.clientSelectedType);

                  print(
                      "Debug: Is form valid? ${clientsController.isFormValid()}");

                  if (clientsController.isFormValid()) {
                    final buildingNum = double.tryParse(
                        clientsController.clientBuildingNumController.text);

                    print("Debug: Parsed building num: $buildingNum");

                    final address = Address(
                      street: clientsController.clientStreetController.text,
                      buildingNumber: int.tryParse(clientsController.clientBuildingNumController.text)?? 0,
                      additionalDirections: clientsController.clientAdditionalInfoController.text,
                      latitude: location.latitude,
                      longitude: location.longitude,
                    );
                    final addressController = Provider.of<AddressController>(context, listen: false);
                    final savedAddress = await addressController.saveAddress(address);

                    clientsController.addNewClient(Client(
                      tradeName: clientsController.clientNameController.text,
                      personInCharge: clientsController.clientPersonInChargeController.text,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      addressId: savedAddress.id!,
                      regionId: clientsController.clientSelectedRegion?.id ?? 1,
                      balance: 0,
                      commercialRegistration: cameraController.getPhotosByType("commercial_registration").firstOrNull ?? "",
                      professionLicensePath: cameraController.getPhotosByType("profession_license").firstOrNull ?? "",
                      nationalId: cameraController.getPhotosByType("id").firstOrNull ?? "",
                      phone: clientsController.clientPhoneController.text,
                      status: "Active",
                      type: clientsController.clientSelectedType ?? "Cash",
                      notes: clientsController.clientNotesController.text,
                    ));

                    print("Debug: New client added successfully.");

                    Navigator.pop(context);

                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title: AppLocalizations.of(context)!.client_creation,
                          imageUrl: "assets/images/success.png",
                          actions: [
                            CustomButtonWidget(
                              title: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                Navigator.pop(context);
                                clientsController.clearClientFields();
                                clientsController.clearErrors();
                                cameraController.clearImages('id');
                                cameraController
                                    .clearImages('commercial_registration');
                                cameraController
                                    .clearImages('profession_license');
                              },
                              borderRadius: 12.r,
                              color:AppConstants.primaryColor2,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    print("Debug: Form validation failed.");
                    final langController = Provider.of<LangController>(context, listen: false);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title: AppLocalizations.of(context)!
                              .something_went_wrong,
                          content: Text(
                            AppLocalizations.of(context)!.fill_all_fields,
                            textAlign: TextAlign.center,
                            style: AppStyles.getFontStyle(
                              langController,
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          imageUrl: "assets/images/cancel.png",
                          actions: [
                            CustomButtonWidget(
                              title: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              borderRadius: 12.r,
                              color:AppConstants.primaryColor2,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Expanded(child: Consumer2<ClientsController, CameraController>(
          builder: (context, clientsController, cameraController, child) {
            return CustomButtonWidget(
              title: AppLocalizations.of(context)!.cancel,
              color:AppConstants.primaryColor2,
              borderRadius: 12.r,
              titleColor: Colors.grey,
              fontSize: 15.sp,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                clientsController.clearClientFields();
                clientsController.clearErrors();
                cameraController.clearImages('id');
                cameraController.clearImages('commercial_registration');
                cameraController.clearImages('profession_license');
              },
            );
          },
        ))
      ],
    );
  }

  String? validateSelectedType(String? selectedType, List<String> typeOptions) {
    if (selectedType == null || !typeOptions.contains(selectedType)) {
      return typeOptions.first;
    }
    return selectedType;
  }
}

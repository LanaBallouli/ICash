import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/camera_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/client_widgets/location_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/client_widgets/upload_photos.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../repository/address_repository.dart';

class UpdateClientDetailsScreen extends StatefulWidget {
  final Client client;
  final int index;
  final LatLng? location;

  const UpdateClientDetailsScreen({
    super.key,
    required this.client,
    required this.index,
    this.location,
  });

  @override
  State<UpdateClientDetailsScreen> createState() => _UpdateClientDetailsScreenState();
}

class _UpdateClientDetailsScreenState extends State<UpdateClientDetailsScreen> {
  late ClientsController clientsController;
  late CameraController cameraController;
  late Address currentAddress;
  late LatLng currentLocation;

  @override
  Future<void> initState() async {
    super.initState();

    clientsController = Provider.of<ClientsController>(context, listen: false);
    cameraController = Provider.of<CameraController>(context, listen: false);

    clientsController.clientNameController.text = widget.client.tradeName;
    clientsController.clientPersonInChargeController.text = widget.client.personInCharge;
    clientsController.clientPhoneController.text = widget.client.phone;
    clientsController.clientNotesController.text = widget.client.notes;
    clientsController.setClientSelectedType(widget.client.type, context);

    final addressRepo = Provider.of<AddressRepository>(context,listen: false);
    currentAddress = await addressRepo.getById(widget.client.addressId);
    clientsController.clientStreetController.text = currentAddress.street;
    clientsController.clientBuildingNumController.text = currentAddress.buildingNumber.toString();
    clientsController.clientAdditionalInfoController.text = currentAddress.additionalDirections ?? "";

    currentLocation = widget.location ??
        LatLng(
          currentAddress.latitude,
          currentAddress.longitude,
        );
  }

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: "${widget.client.tradeName} - ${AppLocalizations.of(context)!.update}",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Consumer3<ClientsController, CameraController, LangController>(
          builder: (context, clientsController, cameraController, lang, _) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  LocationWidget(location: currentLocation, isAddition: true),
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

                  // Trade Name
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_client_trade_name,
                    controller: clientsController.clientNameController,
                    title: AppLocalizations.of(context)!.trade_name,
                    keyboardType: TextInputType.name,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'tradeName', value: value),
                    errorText: clientsController.errors['tradeName'],
                  ),

                  // Person in Charge
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_person_in_charge,
                    controller: clientsController.clientPersonInChargeController,
                    title: AppLocalizations.of(context)!.person_in_charge,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'personInCharge', value: value),
                    errorText: clientsController.errors['personInCharge'],
                    keyboardType: TextInputType.name,
                  ),

                  // Phone
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_client_phone,
                    controller: clientsController.clientPhoneController,
                    title: AppLocalizations.of(context)!.phone,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'phone', value: value),
                    errorText: clientsController.errors['phone'],
                    keyboardType: TextInputType.phone,
                  ),

                  // Street
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_street,
                    controller: clientsController.clientStreetController,
                    title: AppLocalizations.of(context)!.street,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'street', value: value),
                    errorText: clientsController.errors['street'],
                  ),

                  // Building Number
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_building_num,
                    controller: clientsController.clientBuildingNumController,
                    title: AppLocalizations.of(context)!.building_num,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'buildingNum', value: value),
                    errorText: clientsController.errors['buildingNum'],
                  ),

                  // Region Input
                  RegionInputWidget(
                    selectedRegion: clientsController.clientSelectedRegion,
                    hintText: AppLocalizations.of(context)!.choose_region,
                    regions: AppConstants.getRegions(context),
                    onChange: (value) =>
                        clientsController.setClientSelectedRegion(value, context),
                    err: clientsController.errors['region'],
                  ),

                  // Additional Info
                  ManagementInputWidget(
                    hintText: AppLocalizations.of(context)!.enter_additional_info,
                    controller: clientsController.clientAdditionalInfoController,
                    title: AppLocalizations.of(context)!.additional_info,
                    keyboardType: TextInputType.text,
                    errorText: null,
                    onChanged: (value) {},
                  ),

                  // Client Type
                  TypeInputWidget(
                    hintText: AppLocalizations.of(context)!.choose_client_type,
                    typeOptions: [
                      AppLocalizations.of(context)!.cash,
                      AppLocalizations.of(context)!.debt,
                    ],
                    selectedType: clientsController.clientSelectedType,
                    onChange: (value) {
                      clientsController.setClientSelectedType(value, context);
                    },
                    err: clientsController.errors['type'],
                  ),

                  // Conditional Uploads (for Debt clients)
                  if (clientsController.clientSelectedType ==
                      AppLocalizations.of(context)!.debt)
                    ...[
                      SizedBox(height: 15.h),
                      UploadPhotos(
                        title: AppLocalizations.of(context)!.client_id,
                        photoType: "id",
                      ),
                      if (clientsController.errors['id_photos'] != null)
                        Text(
                          clientsController.errors['id_photos']!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),

                      SizedBox(height: 15.h),
                      UploadPhotos(
                        title: AppLocalizations.of(context)!.commercial_registration,
                        photoType: "commercial_registration",
                      ),
                      if (clientsController.errors['commercial_registration_photos'] !=
                          null)
                        Text(
                          clientsController
                              .errors['commercial_registration_photos']!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),

                      SizedBox(height: 15.h),
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

                  // Notes
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

                  // Save and Cancel Buttons
                  _buildButtonsRow(context, clientsController, cameraController),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonsRow(
      BuildContext context,
      ClientsController clientsController,
      CameraController cameraController,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.save,
            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            onPressed: () async {
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
                type: clientsController.clientSelectedType,
              );

              if (!clientsController.isFormValid()) {
                showDialog(
                  context: context,
                  builder: (_) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.fill_all_fields,
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
                      )
                    ],
                  ),
                );
                return;
              }

              final addressRepo =
              Provider.of<AddressRepository>(context, listen: false);

              // Create updated Address object
              final updatedAddress = currentAddress.copyWith(
                street: clientsController.clientStreetController.text,
                buildingNumber: int.tryParse(clientsController.clientBuildingNumController.text) ?? 0,
                additionalDirections: clientsController.clientAdditionalInfoController.text,
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude,
              );

              try {
                // Save updated address
                final savedAddress = await addressRepo.update(updatedAddress);

                // Prepare new client data
                final updatedClient = Client(
                  id: widget.client.id,
                  tradeName: clientsController.clientNameController.text,
                  personInCharge:
                  clientsController.clientPersonInChargeController.text,
                  phone: clientsController.clientPhoneController.text,
                  createdAt: widget.client.createdAt,
                  updatedAt: DateTime.now(),
                  addressId: savedAddress.id!,
                  regionId: clientsController.clientSelectedRegion?.id ?? 1,
                  balance: widget.client.balance,
                  commercialRegistration: cameraController
                      .getPhotosByType("commercial_registration")
                      .firstOrNull ??
                      "",
                  professionLicensePath: cameraController
                      .getPhotosByType("profession_license")
                      .firstOrNull ??
                      "",
                  nationalId: cameraController
                      .getPhotosByType("id")
                      .firstOrNull ??
                      "",
                  status: widget.client.status,
                  type: clientsController.clientSelectedType ?? "Cash",
                  notes: clientsController.clientNotesController.text,
                  invoiceIds: widget.client.invoiceIds,
                );

                await clientsController.updateClient(client: updatedClient,index:  widget.index);

                showDialog(
                  context: context,
                  builder: (_) => DialogWidget(
                    title: AppLocalizations.of(context)!.client_updated,
                    imageUrl: "assets/images/success.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          clientsController.clearClientFields();
                          clientsController.clearErrors();
                          cameraController.clearImages('id');
                          cameraController.clearImages('commercial_registration');
                          cameraController.clearImages('profession_license');
                        },
                        borderRadius: 12.r,
                        colors: [
                          AppConstants.primaryColor2,
                          AppConstants.primaryColor2
                        ],
                      )
                    ],
                  ),
                );
              } catch (e) {
                // Handle errors gracefully
                print("Error updating client: $e");
                showDialog(
                  context: context,
                  builder: (_) => DialogWidget(
                    title: AppLocalizations.of(context)!.error,
                    content: "AppLocalizations.of(context)!.update_failed",
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(width: 20.h),
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.cancel,
            colors: [AppConstants.buttonColor, AppConstants.buttonColor],
            borderRadius: 12.r,
            titleColor: Colors.grey,
            fontSize: 15.sp,
            onPressed: () {
              Navigator.pop(context);
              clientsController.clearClientFields();
              clientsController.clearErrors();
              cameraController.clearImages('id');
              cameraController.clearImages('commercial_registration');
              cameraController.clearImages('profession_license');
            },
          ),
        ),
      ],
    );
  }
}
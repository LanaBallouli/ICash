import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/camera_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/location_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/model/region.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_clinet_widgets/address_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_clinet_widgets/upload_photos.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/notes_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/location_widget.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/management_widgets/add_salesman_widgets/phone_input_widget.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.add_client,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  LocationWidget(),
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
                  NameInputWidget(
                    hintText:
                        AppLocalizations.of(context)!.enter_client_trade_name,
                    nameController: clientsController.clientNameController,
                    title: AppLocalizations.of(context)!.trade_name,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'tradeName', value: value),
                    errorText: clientsController.errors['tradeName'],
                  ),
                  NameInputWidget(
                    hintText:
                        AppLocalizations.of(context)!.enter_person_in_charge,
                    nameController:
                        clientsController.clientPersonInChargeController,
                    title: AppLocalizations.of(context)!.person_in_charge,
                    onChanged: (value) => clientsController.validateField(
                        context: context,
                        field: 'personInCharge',
                        value: value),
                    errorText: clientsController.errors['personInCharge'],
                  ),
                  PhoneInputWidget(
                    phoneController: clientsController.clientPhoneController,
                    hintText: AppLocalizations.of(context)!.enter_client_phone,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'phone', value: value),
                    errorText: clientsController.errors['phone'],
                  ),
                  AddressInputWidget(
                    title: AppLocalizations.of(context)!.street,
                    hintText: AppLocalizations.of(context)!.enter_street,
                    controller: clientsController.clientStreetController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'street', value: value),
                    errorText: clientsController.errors['street'],
                  ),
                  AddressInputWidget(
                    title: AppLocalizations.of(context)!.building_num,
                    hintText: AppLocalizations.of(context)!.enter_building_num,
                    controller: clientsController.clientBuildingNumController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'buildingNum', value: value),
                    errorText: clientsController.errors['buildingNum'],
                  ),
                  RegionInputWidget(
                    selectedRegion: clientsController.clientSelectedRegion,
                    onChanged: (value) => clientsController.validateField(
                        context: context, field: 'region', value: value),
                    err: clientsController.errors['region'],
                    hintText:
                        AppLocalizations.of(context)!.choose_client_region,
                  ),
                  AddressInputWidget(
                    title: AppLocalizations.of(context)!.additional_info,
                    hintText:
                        AppLocalizations.of(context)!.enter_additional_info,
                    controller:
                        clientsController.clientAdditionalInfoController,
                    keyboardType: TextInputType.text,
                    errorText: null,
                    onChanged: (value) {},
                  ),
                  TypeInputWidget(
                    hintText: AppLocalizations.of(context)!.choose_client_type,
                    typeOptions: [
                      AppLocalizations.of(context)!.cash,
                      AppLocalizations.of(context)!.debt
                    ],
                    selectedType: clientsController.clientSelectedType,
                    onChange: (value) {
                      clientsController.setClientSelectedType(value, context);
                    },
                    err: clientsController.errors['type'],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  if (clientsController.clientSelectedType ==
                      AppLocalizations.of(context)!.debt) ...[
                    UploadPhotos(
                      title: AppLocalizations.of(context)!.client_id,
                      photoType: "id",
                    ),
                    UploadPhotos(
                      title:
                          AppLocalizations.of(context)!.commercial_registration,
                      photoType: "commercial_registration",
                    ),
                    UploadPhotos(
                      title: AppLocalizations.of(context)!.profession_license,
                      photoType: "profession_license",
                    ),
                  ],
                  NotesInputWidget(
                      notesController: clientsController.clientNotesController),
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
                colors: [
                  AppConstants.primaryColor2,
                  AppConstants.primaryColor2
                ],
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  // Debug: Log the input values before validation
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

                  // Validate the form
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

                  // Debug: Log whether the form is valid
                  print(
                      "Debug: Is form valid? ${clientsController.isFormValid()}");

                  if (clientsController.isFormValid()) {
                    // Debug: Log the parsed phone and target values
                    final phone = int.tryParse(
                        clientsController.clientPhoneController.text);
                    final buildingNum = double.tryParse(
                        clientsController.clientBuildingNumController.text);

                    print("Debug: Parsed phone number: $phone");
                    print("Debug: Parsed building num: $buildingNum");

                    final double? latitude = double.tryParse(
                        locationController.latitudeController.text);
                    final double? longitude = double.tryParse(
                        locationController.longitudeController.text);

                    clientsController.addNewClient(
                      Client(
                        address: Address(
                          additionalDirections: clientsController
                              .clientAdditionalInfoController.text,
                          buildingNumber: int.tryParse(clientsController
                              .clientBuildingNumController.text),
                          street: clientsController.clientStreetController.text,
                          latitude: latitude,
                          longitude: longitude,
                        ),
                        commercialRegistration: cameraController
                            .getPhotosByType("commercial_registration")
                            .firstOrNull,
                        nationalId:
                            cameraController.getPhotosByType("id").firstOrNull,
                        professionLicensePath: cameraController
                            .getPhotosByType("profession_license")
                            .firstOrNull,
                        personInCharge: clientsController
                            .clientPersonInChargeController.text,
                        createdAt: DateTime.now(),
                        notes: clientsController.clientNotesController.text,
                        phone: int.tryParse(
                            clientsController.clientPhoneController.text),
                        region: Region(
                            name: clientsController.clientSelectedRegion),
                        tradeName: clientsController.clientNameController.text,
                        type: clientsController.clientSelectedType,
                      ),
                    );

                    // Debug: Log success message
                    print("Debug: New client added successfully.");

                    // Navigate back and show success dialog
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
                              colors: [
                                AppConstants.primaryColor2,
                                AppConstants.primaryColor2
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Debug: Log failure message
                    print("Debug: Form validation failed.");

                    // Show error dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title: AppLocalizations.of(context)!
                              .something_went_wrong,
                          content:
                              AppLocalizations.of(context)!.fill_all_fields,
                          imageUrl: "assets/images/cancel.png",
                          actions: [
                            CustomButtonWidget(
                              title: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              borderRadius: 12.r,
                              colors: [
                                AppConstants.primaryColor2,
                                AppConstants.primaryColor2
                              ],
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
        Expanded(child: Consumer<ClientsController>(
          builder: (context, clientsController, child) {
            return CustomButtonWidget(
              title: AppLocalizations.of(context)!.cancel,
              colors: [AppConstants.buttonColor, AppConstants.buttonColor],
              borderRadius: 12.r,
              titleColor: Colors.grey,
              fontSize: 15.sp,
              onPressed: () {
                Navigator.pop(context);
                clientsController.clearClientFields();
                clientsController.clearErrors();
              },
            );
          },
        ))
      ],
    );
  }
}

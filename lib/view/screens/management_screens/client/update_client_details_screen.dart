import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';

import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../model/region.dart';
import '../../../widgets/management_widgets/client_widgets/location_widget.dart';
import '../../../widgets/management_widgets/client_widgets/upload_photos.dart';

class UpdateClientDetailsScreen extends StatefulWidget {
  final Client client;
  final int index;

  const UpdateClientDetailsScreen({
    super.key,
    required this.client,
    required this.index,
  });

  @override
  State<UpdateClientDetailsScreen> createState() =>
      _UpdateClientDetailsScreenState();
}

class _UpdateClientDetailsScreenState extends State<UpdateClientDetailsScreen> {
  late ClientsController clientsController;

  @override
  void initState() {
    super.initState();
    clientsController = Provider.of<ClientsController>(context, listen: false);

    clientsController.clientNameController.text = widget.client.tradeName ?? "";
    clientsController.clientPersonInChargeController.text =
        widget.client.personInCharge ?? "";
    clientsController.clientPhoneController.text =
        widget.client.phone.toString();
    clientsController.clientStreetController.text =
        widget.client.address?.street ?? "";
    clientsController.clientBuildingNumController.text =
        widget.client.address!.buildingNumber.toString();
    clientsController.setClientSelectedRegion(
        widget.client.region!.name, context);
    clientsController.setClientSelectedType(widget.client.type, context);
    clientsController.clientAdditionalInfoController.text =
        widget.client.address?.additionalDirections ?? "";
    clientsController.clientNotesController.text = widget.client.notes ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
            "${widget.client.tradeName} - ${AppLocalizations.of(context)!.update}",
        leading: Consumer<ClientsController>(
          builder: (context, clientsController, child) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Consumer<ClientsController>(
          builder: (context, clientsController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                LocationWidget(
                  location: LatLng(widget.client.address!.latitude!,
                      widget.client.address!.longitude!),
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
                  controller: clientsController.clientPersonInChargeController,
                  title: AppLocalizations.of(context)!.person_in_charge,
                  onChanged: (value) => clientsController.validateField(
                      context: context, field: 'personInCharge', value: value),
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
                  typeOptions: [
                    'Amman',
                    "Zarqaa",
                  ],
                  selectedRegion: clientsController.clientSelectedRegion,
                  onChange: (value) =>
                      clientsController.setClientSelectedRegion(value, context),
                  err: clientsController.errors['region'],
                  hintText: AppLocalizations.of(context)!.choose_client_region,
                ),
                ManagementInputWidget(
                  hintText: AppLocalizations.of(context)!.enter_additional_info,
                  controller: clientsController.clientAdditionalInfoController,
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
                  selectedType: clientsController.clientSelectedType,
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
                _buildButtonsRow(context, clientsController),
                SizedBox(height: 30.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonsRow(
      BuildContext context, ClientsController clientsController) {
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
            onPressed: () {
              // Validate form
              clientsController.validateForm(
                  context: context,
                  type: clientsController.clientSelectedType,
                  tradeName: clientsController.clientNameController.text,
                  region: clientsController.clientSelectedRegion,
                  phone: clientsController.clientPhoneController.text,
                  personInCharge:
                      clientsController.clientPersonInChargeController.text,
                  street: clientsController.clientStreetController.text,
                  buildingNum: int.tryParse(
                      clientsController.clientBuildingNumController.text));

              if (!clientsController.isFormValid()) {
                // Show error dialog if form is invalid
                showDialog(
                  context: context,
                  builder: (context) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.fill_all_fields,
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [
                          AppConstants.primaryColor2,
                          AppConstants.primaryColor2
                        ],
                      )
                    ],
                  ),
                );
                return;
              }

              final phone =
                  int.tryParse(clientsController.clientPhoneController.text);
              final buildingNum = int.tryParse(
                  clientsController.clientBuildingNumController.text);

              if (phone == null || buildingNum == null) {
                showDialog(
                  context: context,
                  builder: (context) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.fill_all_fields,
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [
                          AppConstants.primaryColor2,
                          AppConstants.primaryColor2
                        ],
                      )
                    ],
                  ),
                );
                return;
              }

              final updatedClient = Client(
                id: widget.client.id,
                personInCharge:
                    clientsController.clientPersonInChargeController.text,
                phone: phone,
                region: Region(name: clientsController.clientSelectedRegion),
                tradeName: clientsController.clientNameController.text,
                type: clientsController.clientSelectedType,
                notes: clientsController.clientNotesController.text,
                createdAt: widget.client.createdAt,
                address: Address(
                  street: clientsController.clientStreetController.text,
                  additionalDirections:
                      clientsController.clientAdditionalInfoController.text,
                  buildingNumber: buildingNum,
                  longitude: widget.client.address?.longitude,
                  latitude: widget.client.address?.latitude,
                ),
                updatedAt: DateTime.now(),
              );

              clientsController.updateClient(
                  client: updatedClient, index: widget.index);

              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: AppLocalizations.of(context)!.salesman_updated,
                  imageUrl: "assets/images/success.png",
                  actions: [
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.ok,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        clientsController.clearClientFields();
                        clientsController.clearErrors();
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
            },
          ),
        ),
      ],
    );
  }
}

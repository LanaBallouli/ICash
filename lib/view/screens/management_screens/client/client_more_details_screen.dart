import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/screens/management_screens/client/set_location_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/client_widgets/location_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/more_details_widget.dart';
import '../../../../controller/camera_controller.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';

class ClientMoreDetailsScreen extends StatelessWidget {
  final Client client;
  final int index;

  const ClientMoreDetailsScreen(
      {super.key, required this.client, required this.index});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
            "${client.tradeName ?? "Name"} - ${AppLocalizations.of(context)!.details}",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationWidget(
                isAddition: false,
                location: LatLng(client.address?.latitude ?? 31.985934703432616,
                    client.address?.longitude ?? 35.900362288558114),
              ),
              _buildProfileSection(context, langController),
              SizedBox(height: 10.h),
              _buildAddressSection(context),
              SizedBox(height: 10.h),
              _buildAssignedClientsSection(context),
              SizedBox(height: 10.h),
              _buildPerformanceSection(context),
              SizedBox(height: 10.h),
              _buildRecentActivitySection(context),
              SizedBox(height: 10.h),
              _buildDocumentsSection(context),
              SizedBox(height: 10.h),
              _buildFeedbackSection(context),
              SizedBox(height: 20.h),
              _buildButtonsRow(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(
      BuildContext context, LangController langController) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.profile,
      leadingIcon: Icons.person_outline_rounded,
      initExpanded: false,
      children: _buildProfileInputs(context, langController),
    );
  }

  List<Widget> _buildProfileInputs(
      BuildContext context, LangController langController) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {
        "label": AppLocalizations.of(context)!.trade_name,
        "value": client.tradeName ?? "name"
      },
      {
        "label": AppLocalizations.of(context)!.person_in_charge,
        "value": client.personInCharge ?? "name"
      },
      {
        "label": AppLocalizations.of(context)!.phone,
        "value": client.phone ?? "1246789"
      },
      {
        "label": AppLocalizations.of(context)!.joining_date,
        "value":
            formatDateWithTime(client.createdAt ?? DateTime.now()).toString()
      },
      {
        "label": AppLocalizations.of(context)!.type,
        "value": client.type ?? "type"
      }
    ];

    return profileDetails.map((detail) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            InputWidget(
              textEditingController:
                  TextEditingController(text: detail["value"] ?? ""),
              label: "${detail["label"]}",
              readOnly: true,
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAddressSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.address,
      leadingIcon: Icons.location_on_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: client.region?.name ?? "region"),
            readOnly: true,
            label: AppLocalizations.of(context)!.region,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: client.address?.street ?? "street"),
            readOnly: true,
            label: AppLocalizations.of(context)!.street,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(
                text: client.address?.buildingNumber.toString() ??
                    "building num"),
            readOnly: true,
            label: AppLocalizations.of(context)!.building_num,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(
                text: client.address?.additionalDirections ??
                    "Additional Directions"),
            readOnly: true,
            label: AppLocalizations.of(context)!.additional_info,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.performance,
      leadingIcon: Icons.assessment_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(),
            readOnly: true,
            label: AppLocalizations.of(context)!.total_sales,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(),
            readOnly: true,
            label: AppLocalizations.of(context)!.monthly_sales,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(),
            readOnly: true,
            label: AppLocalizations.of(context)!.sales_history,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(),
            readOnly: true,
            label: AppLocalizations.of(context)!.average_order_value,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    String getLatestInvoiceAmount() {
      if (client.invoices != null && client.invoices!.isNotEmpty) {
        final latestInvoice = client.invoices!.reduce((current, next) => (next
                    .creationTime
                    ?.isAfter(current.creationTime ?? DateTime.now()) ??
                false)
            ? next
            : current);
        return latestInvoice.calculateTotalAmount().toString();
      } else {
        return "No invoices available";
      }
    }

    String getLatestVisitDate() {
      if (client.visits != null && client.visits!.isNotEmpty) {
        final latestVisit = client.visits!.reduce((current, next) =>
            (next.visitDate?.isAfter(current.visitDate ?? DateTime.now()) ??
                    false)
                ? next
                : current);
        return formatDateWithTime(latestVisit.visitDate ?? DateTime.now());
      } else {
        return "No visits available";
      }
    }

    final String latestInvoiceAmount = getLatestInvoiceAmount();
    final String latestVisitDate = getLatestVisitDate();

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.recent_activity_log,
      leadingIcon: Icons.access_time,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: latestInvoiceAmount),
            label: AppLocalizations.of(context)!.latest_invoice,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: latestVisitDate),
            label: AppLocalizations.of(context)!.latest_visit,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildAssignedClientsSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.assigned_salesmen,
      leadingIcon: Icons.groups_2_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: client.assignedSalesmen == null ||
                  client.assignedSalesmen!.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_assigned_clients,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: client.assignedSalesmen?.length ?? 0,
                  itemBuilder: (context, index) {
                    final users = client.assignedSalesmen![index];
                    return Column(
                      children: [
                        InputWidget(
                          textEditingController: TextEditingController(
                              text: users.fullName ?? "Unknown Salesman"),
                          label: AppLocalizations.of(context)!.salesman_name,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward)),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.location_history_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            height: 100.h,
            textEditingController:
                TextEditingController(text: client.notes ?? ""),
            label: AppLocalizations.of(context)!.notes,
            readOnly: true,
            maxLines: 3,
          ),
        )
      ],
    );
  }

  Widget _buildDocumentsSection(BuildContext context) {
    final cameraController = Provider.of<CameraController>(context);
    List<String> idPhotos = cameraController.getPhotosByType('id');
    List<String> commercialRegistrationPhotos =
        cameraController.getPhotosByType('commercial_registration');
    List<String> professionLicensePhotos =
        cameraController.getPhotosByType('profession_license');

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.documents_section,
      leadingIcon: Icons.attach_file,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              _buildDocumentInputField(
                context: context,
                label: AppLocalizations.of(context)!.client_id,
                photos: idPhotos,
                photoType: 'id',
                cameraController: cameraController,
                controllerText: client.nationalId,
              ),
              SizedBox(height: 10.h),
              _buildDocumentInputField(
                context: context,
                label: AppLocalizations.of(context)!.commercial_registration,
                photos: commercialRegistrationPhotos,
                photoType: 'commercial_registration',
                cameraController: cameraController,
              ),
              SizedBox(height: 10.h),
              _buildDocumentInputField(
                context: context,
                label: AppLocalizations.of(context)!.profession_license,
                photos: professionLicensePhotos,
                photoType: 'profession_license',
                cameraController: cameraController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentInputField({
    required BuildContext context,
    required String label,
    required List<String> photos,
    required String photoType,
    required CameraController cameraController,
    String? controllerText,
  }) {
    return InputWidget(
      textEditingController: TextEditingController(text: controllerText),
      suffixIcon: Icon(Icons.camera_alt_outlined),
      readOnly: true,
      label: label,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              icon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              content: photos.isEmpty
                  ? Text("AppLocalizations.of(context)!.no_documents_uploaded")
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: photos.map((base64String) {
                        try {
                          return Stack(
                            children: [
                              Image.memory(
                                base64Decode(base64String),
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    cameraController.removeImage(
                                        base64String, photoType);
                                  },
                                  child: Icon(Icons.close,
                                      color: Colors.red, size: 18.sp),
                                ),
                              ),
                            ],
                          );
                        } catch (e) {
                          return Text(
                              "AppLocalizations.of(context)!.invalid_image");
                        }
                      }).toList(),
                    ),
            );
          },
        );
      },
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Consumer<ManagementController>(
            builder: (context, managementController, child) {
              return CustomButtonWidget(
                title: AppLocalizations.of(context)!.update,
                colors: [
                  AppConstants.primaryColor2,
                  AppConstants.primaryColor2
                ],
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetLocationScreen(
                        isEditMode: true,
                        initialLocation: LatLng(
                          client.address!.latitude!,
                          client.address!.longitude!,
                        ),
                        client: client,
                        index: index,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.delete,
            colors: [Color(0xFF910000), Color(0xFF910000)],
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            onPressed: () {
              _deleteCurrentUser(context);
            },
          ),
        )
      ],
    );
  }

  void _deleteCurrentUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ClientsController>(
          builder: (context, clientsController, child) {
            return DialogWidget(
              title: AppLocalizations.of(context)!.confirm_deletion,
              content: AppLocalizations.of(context)!.delete_client,
              imageUrl: "assets/images/cancel.png",
              onPressed: () {
                clientsController.deleteUser(client);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}

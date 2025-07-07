import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/address_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/screens/management_screens/client/update_client_details_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/main/more_details_widget.dart';

import '../../../../controller/camera_controller.dart';
import '../../../../controller/invoice_controller.dart';
import '../../../../controller/visit_controller.dart';

class ClientMoreDetailsScreen extends StatefulWidget {
  final Client client;
  final int index;

  const ClientMoreDetailsScreen({
    super.key,
    required this.client,
    required this.index,
  });

  @override
  State<ClientMoreDetailsScreen> createState() =>
      _ClientMoreDetailsScreenState();
}

class _ClientMoreDetailsScreenState extends State<ClientMoreDetailsScreen> {
  late AddressController addressController;
  late ClientsController clientsController;
  late SalesmanController salesmenController;
  late InvoicesController invoicesController;
  late VisitsController visitsController;

  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasLoaded) return;

    // Get controllers once
    addressController = Provider.of<AddressController>(context, listen: false);
    clientsController = Provider.of<ClientsController>(context, listen: false);
    salesmenController =
        Provider.of<SalesmanController>(context, listen: false);
    invoicesController =
        Provider.of<InvoicesController>(context, listen: false);
    visitsController = Provider.of<VisitsController>(context, listen: false);

    _hasLoaded = true; // Prevent re-init

    // Defer data loading until after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(context);
    });
  }

  Future<void> _loadData(BuildContext context) async {
    final client = widget.client;

    try {
      final address =
          await addressController.fetchAddressById(client.addressId);

      if (address != null) {
        clientsController.clientStreetController.text = address.street;
        clientsController.clientBuildingNumController.text =
            address.buildingNumber.toString();
        clientsController.clientAdditionalInfoController.text =
            address.additionalDirections ?? "";
      }
    
      if (client.id != null) {
        salesmenController.getAssignedSalesmen(client.id!);
        invoicesController.fetchInvoicesByClient(client.id!);
        visitsController.fetchVisitsByClient(client.id!);
      }
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
          title: "${widget.client.tradeName} - ${local.details}"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Consumer2<SalesmanController, ClientsController>(
          builder: (context, salesmenCtrl, clientCtrl, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(context, widget.client),
                  SizedBox(height: 15.h),
                  _buildAddressSection(context, addressController),
                  SizedBox(height: 15.h),
                  _buildPerformanceSection(context, invoicesController),
                  SizedBox(height: 15.h),
                  _buildRecentActivitySection(context, visitsController),
                  SizedBox(height: 15.h),
                  _buildAssignedSalesmenSection(context, salesmenController),
                  SizedBox(height: 15.h),
                  _buildFeedbackSection(context, clientCtrl),
                  SizedBox(height: 20.h),
                  if (widget.client.type == "Debt") ...[
                    _buildDocumentsSection(context),
                    SizedBox(height: 20.h),
                  ],
                  _buildButtonsRow(context),
                  SizedBox(height: 15.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, Client client) {
    final local = AppLocalizations.of(context)!;

    String formatDate(DateTime? dateTime) {
      if (dateTime == null) return "local.n_a";
      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {
        "label": local.trade_name,
        "value": client.tradeName,
      },
      {
        "label": local.person_in_charge,
        "value": client.personInCharge,
      },
      {
        "label": local.phone,
        "value": client.phone,
      },
      {
        "label": local.type,
        "value": client.type,
      },
      {
        "label": local.joining_date,
        "value": formatDate(client.createdAt),
      },
    ];

    return MoreDetailsWidget(
      title: local.profile,
      leadingIcon: Icons.person_outline_rounded,
      children: profileDetails.map((detail) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputWidget(
                textEditingController:
                    TextEditingController(text: detail["value"]),
                label: detail["label"],
                readOnly: true,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddressSection(
      BuildContext context, AddressController addressCtrl) {
    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: local.address,
      leadingIcon: Icons.location_on_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(
              text: addressCtrl
                      .getAddressFromList(widget.client.addressId)
                      ?.street ??
                  local.loading,
            ),
            label: local.street,
            readOnly: true,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(
              text: addressCtrl
                      .getAddressFromList(widget.client.addressId)
                      ?.buildingNumber
                      .toString() ??
                  local.loading,
            ),
            label: local.building_num,
            readOnly: true,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            height: 100.h,
            textEditingController: TextEditingController(
              text: addressCtrl
                      .getAddressFromList(widget.client.addressId)
                      ?.additionalDirections ??
                  "",
            ),
            label: local.additional_info,
            readOnly: true,
            maxLines: 3,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildPerformanceSection(
      BuildContext context, InvoicesController invoiceCtrl) {
    final local = AppLocalizations.of(context)!;

    double totalSales = 0.0;
    if (invoiceCtrl.invoices.isNotEmpty) {
      totalSales = invoiceCtrl.getTotalSalesForClient(widget.client.id!);
    }

    return MoreDetailsWidget(
      title: local.performance,
      leadingIcon: Icons.assessment_outlined,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: "$totalSales JD"),
            label: local.total_sales,
            readOnly: true,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InputWidget(
            textEditingController: TextEditingController(
              text: invoiceCtrl.invoices.length.toString(),
            ),
            label: local.total,
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(
      BuildContext context, VisitsController visitCtrl) {
    final local = AppLocalizations.of(context)!;

    String latestVisitDate = "local.n_a";
    if (visitCtrl.visits.isNotEmpty) {
      final latest = visitCtrl.visits
          .reduce((a, b) => a.visitDate.isAfter(b.visitDate) ? a : b);
      latestVisitDate = DateFormat('yyyy-MM-dd').format(latest.visitDate);
    }

    return MoreDetailsWidget(
      title: local.recent_activity_log,
      leadingIcon: Icons.access_time,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InputWidget(
            textEditingController: TextEditingController(text: latestVisitDate),
            label: local.latest_visit,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InputWidget(
            textEditingController: TextEditingController(text: "N/A"),
            label: local.next_visit,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignedSalesmenSection(
      BuildContext context, SalesmanController salesmenCtrl) {
    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: local.assigned_salesmen,
      leadingIcon: Icons.groups_2_outlined,
      children: [
        if (salesmenCtrl.assignedSalesmen.isEmpty)
          Center(child: Text("local.no_assigned_salesmen"))
        else
          ...salesmenCtrl.assignedSalesmen.map((salesman) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InputWidget(
                textEditingController:
                    TextEditingController(text: salesman.fullName),
                label: local.salesman_name,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_outlined),
                ),
              ),
            );
          })
      ],
    );
  }

  Widget _buildFeedbackSection(BuildContext context, ClientsController ctrl) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.message_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            height: 100.h,
            textEditingController: TextEditingController(
              text: widget.client.notes ?? "",
            ),
            label: AppLocalizations.of(context)!.notes,
            readOnly: true,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(BuildContext context) {
    final cameraController = Provider.of<CameraController>(context);

    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: local.documents_section,
      leadingIcon: Icons.attach_file,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(
                text: cameraController.getPhotosByType('id').isNotEmpty
                    ? "local.photos_attached"
                    : " local.no_photos_yet,"),
            label: "local.national_id",
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
            textEditingController: TextEditingController(
              text: cameraController
                      .getPhotosByType('commercial_registration')
                      .isNotEmpty
                  ? "local.photos_attached"
                  : "local.no_photos_yet",
            ),
            label: local.commercial_registration,
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
            textEditingController: TextEditingController(
              text: cameraController
                      .getPhotosByType('profession_license')
                      .isNotEmpty
                  ? "local.photos_attached"
                  : " local.no_photos_yet",
            ),
            label: local.profession_license,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButtonWidget(
            title: local.update,
            color:AppConstants.primaryColor2,
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateClientDetailsScreen(
                    client: widget.client,
                    index: widget.index,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 20.h),
        Expanded(
          child: CustomButtonWidget(
            title: local.delete,
            color: Colors.red,
            titleColor: Colors.white,
            fontSize: 15.sp,
            borderRadius: 12.r,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: local.confirm_deletion,
                  content: local.delete_client,
                  imageUrl: "assets/images/cancel.png",
                  actions: [
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: Text(local.cancel),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await clientsController
                              .deleteClient(widget.client.id!);
                          await addressController
                              .deleteAddress(widget.client.addressId);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                      child: Text(local.delete),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

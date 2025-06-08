import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenUtil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/screens/management_screens/client/update_client_details_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/main/more_details_widget.dart';
import 'package:test_sales/view/screens/management_screens/client/set_location_screen.dart';

import '../../../../controller/address_controller.dart';

class ClientMoreDetailsScreen extends StatefulWidget {
  final Client client;
  final int index;

  const ClientMoreDetailsScreen({
    super.key,
    required this.client,
    required this.index,
  });

  @override
  State<ClientMoreDetailsScreen> createState() => _ClientMoreDetailsScreenState();
}

class _ClientMoreDetailsScreenState extends State<ClientMoreDetailsScreen> {
  late ClientsController clientsController;
  late Address? address;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final addressCtrl = Provider.of<AddressController>(context, listen: false);

      if (widget.client.addressId != null) {
        addressCtrl.fetchAddressById(widget.client.addressId!).then((addr) {
          setState(() {
            address = addr;
          });
        }).catchError((e) {
          print("Failed to load address: $e");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context, listen: false);
    final clientsController = Provider.of<ClientsController>(context);
    final addressCtrl = Provider.of<AddressController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: "${widget.client.tradeName} - ${local.details}",
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(context, langController),
              SizedBox(height: 15.h),
              _buildAddressSection(context, addressCtrl),
              SizedBox(height: 15.h),
              _buildPerformanceSection(context),
              SizedBox(height: 15.h),
              _buildRecentActivitySection(context),
              SizedBox(height: 15.h),
              // _buildAssignedSalesmenSection(context),
              // SizedBox(height: 15.h),
              _buildFeedbackSection(context),
              SizedBox(height: 20.h),
              _buildButtonsRow(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Build Sections ---

  Widget _buildProfileSection(BuildContext context, LangController langController) {
    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.profile,
      leadingIcon: Icons.person_outline_rounded,
      children: _buildProfileInputs(context, langController),
    );
  }

  List<Widget> _buildProfileInputs(BuildContext context, LangController langController) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {
        "label": AppLocalizations.of(context)!.trade_name,
        "value": widget.client.tradeName ,
      },
      {
        "label": AppLocalizations.of(context)!.person_in_charge,
        "value": widget.client.personInCharge ,
      },
      {
        "label": AppLocalizations.of(context)!.phone,
        "value": widget.client.phone,
      },
      {
        "label": AppLocalizations.of(context)!.type,
        "value": widget.client.type,
      },
      {
        "label": AppLocalizations.of(context)!.joining_date,
        "value": formatDateWithTime(widget.client.createdAt),
      },
    ];

    return profileDetails.map((detail) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWidget(
            textEditingController: TextEditingController(text: detail["value"]),
            label: detail["label"],
            readOnly: true,
            borderRaduis: 0.r,
          ),
          SizedBox(height: 10.h),
        ],
      );
    }).toList();
  }

  Widget _buildAddressSection(BuildContext context, AddressController addressController) {
    final local = AppLocalizations.of(context)!;

    if (address == null && !addressController.isLoading) {
      return MoreDetailsWidget(
        title: local.address,
        leadingIcon: Icons.location_on_outlined,
        children: [
          Center(
            child: Text("local.no_address_assigned"),
          ),
        ],
      );
    }

    return MoreDetailsWidget(
      title: local.address,
      leadingIcon: Icons.location_on_outlined,
      children: [
        InputWidget(
          textEditingController: TextEditingController(text: address?.street ?? local.loading),
          label: local.street,
          readOnly: true,
        ),
        SizedBox(height: 10.h),
        InputWidget(
          textEditingController: TextEditingController(
              text: address?.buildingNumber.toString() ?? local.loading),
          label: local.building_num,
          readOnly: true,
        ),
        SizedBox(height: 10.h),
        InputWidget(
          textEditingController:
          TextEditingController(text: address?.additionalDirections ?? ""),
          label: local.additional_info,
          readOnly: true,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: local.performance,
      leadingIcon: Icons.assessment_outlined,
      children: [
        InputWidget(
          textEditingController:
          TextEditingController(text: widget.client.balance.toStringAsFixed(2)),
          label: "local.total_balance",
          readOnly: true,
        ),
        SizedBox(height: 10.h),
        // InputWidget(
        //   textEditingController: TextEditingController(
        //       text: widget.client.invoiceIds.length.toString()),
        //   label: local.total_invoices,
        //   readOnly: true,
        // ),
        SizedBox(height: 10.h),
        InputWidget(
          textEditingController: TextEditingController(text: "N/A"),
          label: local.monthly_target_achievement,
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MoreDetailsWidget(
      title: local.recent_activity_log,
      leadingIcon: Icons.access_time,
      children: [
        InputWidget(
          textEditingController: TextEditingController(text: "N/A"),
          label: local.latest_invoice,
          readOnly: true,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_outlined),
          ),
        ),
        SizedBox(height: 10.h),
        InputWidget(
          textEditingController: TextEditingController(text: "N/A"),
          label: local.latest_visit,
          readOnly: true,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_outlined),
          ),
        ),
        SizedBox(height: 10.h),
        InputWidget(
          textEditingController: TextEditingController(text: "N/A"),
          label: local.next_visit,
          readOnly: true,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_outlined),
          ),
        ),
      ],
    );
  }

  // Widget _buildAssignedSalesmenSection(BuildContext context) {
  //   final local = AppLocalizations.of(context)!;
  //
  //   // return MoreDetailsWidget(
  //   //   title: local.assigned_salesmen,
  //   //   leadingIcon: Icons.groups_2_outlined,
  //   //   children: [
  //   //     if (widget.client.assignedSalesmenIds.isEmpty)
  //   //       Center(child: Text(local.no_assigned_salesmen))
  //   //     else
  //   //       ...widget.client.assignedSalesmenIds.map((salesmanId) {
  //   //         final salesman = Salesman.byId(salesmanId);
  //   //         return InputWidget(
  //   //           textEditingController: TextEditingController(
  //   //               text: salesman?.fullName ?? local.loading),
  //   //           label: local.salesman_name,
  //   //           readOnly: true,
  //   //           suffixIcon: IconButton(
  //   //             onPressed: () {},
  //   //             icon: Icon(Icons.arrow_forward_outlined),
  //   //           ),
  //   //         );
  //   //       }).toList(),
  //   //   ],
  //   // );
  // }

  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.location_history_outlined,
      children: [
        InputWidget(
          height: 100.h,
          textEditingController:
          TextEditingController(text: widget.client.notes ?? ""),
          label: AppLocalizations.of(context)!.notes,
          readOnly: true,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.update,
            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
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
            title: AppLocalizations.of(context)!.delete,
            colors: [Colors.red, Colors.redAccent],
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        )
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: AppLocalizations.of(context)!.confirm_deletion,
          content: AppLocalizations.of(context)!.delete_client,
          imageUrl: "assets/images/cancel.png",
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await clientsController.deleteClient(widget.client.id!);
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back
                } catch (e) {
                  print("Error deleting client: $e");
                  // Show error dialog
                }
              },
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    );
  }
}
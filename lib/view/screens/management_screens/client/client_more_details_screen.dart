import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/main/more_details_widget.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:provider/provider.dart';
import '../../../../controller/salesman_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/salesman.dart';
import '../../../widgets/main_widgets/input_widget.dart';

class ClientMoreDetailsScreen extends StatelessWidget {
  final Client client;
  final int index;

  const ClientMoreDetailsScreen({
    super.key,
    required this.client,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: "${client.tradeName} - ${client.personInCharge}",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Profile Details
              _buildProfileSection(context),
              SizedBox(height: 20.h),

              // Recent Activity
              _buildRecentActivitySection(context),
              SizedBox(height: 20.h),

              // Assigned Salesmen
              _buildAssignedSalesmenSection(context),
              SizedBox(height: 20.h),

              // Feedback / Notes
              _buildFeedbackSection(context),
              SizedBox(height: 40.h),

              // Delete Button
              CustomButtonWidget(
                title: AppLocalizations.of(context)!.delete,
                colors: [Colors.red, Colors.redAccent],
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  _showDeleteDialog(context, client, index);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final clientsController = Provider.of<ClientsController>(context, listen: false);

    final List<Map<String, String?>> profileDetails = [
      {'label': 'Trade Name', 'value': client.tradeName},
      {'label': 'Person in Charge', 'value': client.personInCharge},
      {'label': 'Phone', 'value': client.phone},
      {'label': 'Region', 'value': clientsController.getRegionName(client.regionId, context)},
      {'label': 'Balance', 'value': client.balance.toStringAsFixed(2)},
      {'label': 'Type', 'value': client.type},
      {'label': 'Status', 'value': client.status},
    ];

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.profile,
      leadingIcon: Icons.person_outline,
      children: profileDetails.map((detail) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
            TextEditingController(text: detail['value']),
            label: detail['label'] ?? "",
            readOnly: true,
            suffixIcon: Icon(Icons.lock_clock),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    final recentActivity = [
      {
        'label': AppLocalizations.of(context)!.latest_invoice,
        'value': "JD ${client.balance.toStringAsFixed(2)}",
        'time': "2024-08-10"
      },
      {
        'label': AppLocalizations.of(context)!.latest_visit,
        'value': "AppLocalizations.of(context)!.visited_on",
        'time': "2024-08-10"
      },
    ];

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.recent_activity_log,
      leadingIcon: Icons.access_time,
      children: recentActivity.map((activity) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
            TextEditingController(text: activity['value']),
            label: "${activity['label']} • ${activity['time']}",
            readOnly: true,
            suffixIcon: Icon(Icons.arrow_forward_outlined),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAssignedSalesmenSection(BuildContext context) {
    final salesmanController = Provider.of<SalesmanController>(context, listen: false);

    return FutureBuilder<List<SalesMan>>(
      future: salesmanController.getAssignedSalesmen(client.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MoreDetailsWidget(
            title: AppLocalizations.of(context)!.assigned_salesmen,
            leadingIcon: Icons.groups_2_outlined,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        }

        if (snapshot.hasError) {
          return MoreDetailsWidget(
            title: AppLocalizations.of(context)!.assigned_salesmen,
            leadingIcon: Icons.groups_2_outlined,
            children: [
              Center(
                child: Text(
                  "${"AppLocalizations.of(context)!.failed_to_load_data"}: ${snapshot.error}",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        }

        final salesmen = snapshot.data ?? [];

        if (salesmen.isEmpty) {
          return MoreDetailsWidget(
            title: AppLocalizations.of(context)!.assigned_salesmen,
            leadingIcon: Icons.groups_2_outlined,
            children: [
              Center(
                child: Text(
                  "AppLocalizations.of(context)!.no_assigned_salesmen",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          );
        }

        return MoreDetailsWidget(
          title: AppLocalizations.of(context)!.assigned_salesmen,
          leadingIcon: Icons.groups_2_outlined,
          children: salesmen.map((salesman) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InputWidget(
                textEditingController: TextEditingController(text: salesman.fullName),
                label: AppLocalizations.of(context)!.salesman_name,
                readOnly: true,
                suffixIcon: Icon(Icons.arrow_forward),
              ),
            );
          }).toList(),
        );
      },
    );
  }
  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.edit_note_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
            TextEditingController(text: client.notes ?? ""),
            label: AppLocalizations.of(context)!.notes,
            readOnly: true,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(
      BuildContext context, Client client, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: AppLocalizations.of(context)!.confirm_deletion,
          content: AppLocalizations.of(context)!.delete_client,
          imageUrl: "assets/images/cancel.png",
          actions: [
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.ok,
              onPressed: () {
                Provider.of<ClientsController>(context, listen: false)
                    .deleteClient(client.id!);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              borderRadius: 12.r,
              colors: [Colors.red, Colors.redAccent],
            ),
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.cancel,
              onPressed: Navigator.of(context).pop,
              borderRadius: 12.r,
              colors: [Colors.grey.shade300, Colors.grey.shade400],
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/clients_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/salesman.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class AssignedClientsSection extends StatelessWidget {
  final SalesMan salesman;

  const AssignedClientsSection({super.key, required this.salesman});

  @override
  Widget build(BuildContext context) {
    final clientsController = Provider.of<ClientsController>(context);

    final shouldFetch = salesman.id != null &&
        !clientsController.isLoading &&
        clientsController.lastFetchedSalesmanId != salesman.id;

    if (shouldFetch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        clientsController.fetchClientsBySalesman(salesman.id!);
      });
    }

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.assigned_clients,
      leadingIcon: Icons.groups_2_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _buildClientList(context, clientsController),
        ),
      ],
    );
  }

  Widget _buildClientList(BuildContext context, ClientsController controller) {
    final local = AppLocalizations.of(context)!;

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.isNotEmpty) {
      return Text(
        controller.errorMessage,
        style: TextStyle(color: Colors.red),
      );
    }

    if (controller.clients.isEmpty) {
      return Center(
        child: Text(local.no_assigned_clients),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.clients.length,
      itemBuilder: (context, index) {
        final client = controller.clients[index];
        return Column(
          children: [
            InputWidget(
              textEditingController:
              TextEditingController(text: client.tradeName ?? "N/A"),
              label: AppLocalizations.of(context)!.client_name,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ),
              readOnly: true,
            ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }}
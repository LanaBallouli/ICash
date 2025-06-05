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

    if (!clientsController.isLoading &&
        (clientsController.clients.isEmpty || salesman.id != null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (salesman.id != null) {
          clientsController.fetchClientsBySalesman(salesman.id!);
        }
      });
    }

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.assigned_clients,
      leadingIcon: Icons.groups_2_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: clientsController.isLoading
              ? Center(child: CircularProgressIndicator())
              : clientsController.clients.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_assigned_clients,
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: clientsController.clients.length,
                      itemBuilder: (context, index) {
                        final client = clientsController.clients[index];
                        return Column(
                          children: [
                            InputWidget(
                              textEditingController: TextEditingController(
                                  text: client.tradeName ?? "Unknown Client"),
                              label: AppLocalizations.of(context)!.client_name,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // Optional: Navigate to client details
                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                              readOnly: true,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        );
                      },
                    ),
        )
      ],
    );
  }
}

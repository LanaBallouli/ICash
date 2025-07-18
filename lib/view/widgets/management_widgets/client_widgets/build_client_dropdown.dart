import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../app_constants.dart';
import '../../../../controller/clients_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/client.dart';
import '../../home_widgets/build_client_bottom_sheet.dart';

DropdownButton<Client> buildClientDropdown(
    BuildContext context,
    Client? selectedClient,
    Function(Client?) onClientSelected,
    ) {
  final clientsCtrl = Provider.of<ClientsController>(context, listen: false);
  final local = AppLocalizations.of(context)!;

  return DropdownButton<Client>(
    isExpanded: true,
    hint: Text(local.select_client),
    value: selectedClient,
    underline: Container(),
    dropdownColor: Colors.white,
    items: [
      DropdownMenuItem<Client>(
        value: null,
        child: Row(
          children: [
            Icon(Icons.add, color: AppConstants.primaryColor2),
            SizedBox(width: 8.w),
            Text(
              local.add_new_client,
              style: TextStyle(color: AppConstants.primaryColor2),
            ),
          ],
        ),
      ),

      ...clientsCtrl.clients.map<DropdownMenuItem<Client>>((client) {
        return DropdownMenuItem<Client>(
          value: client,
          child: Text(client.tradeName),
        );
      }).toList(),
    ],
    onChanged: (client) async {
      if (client == null) {
        try {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          final currentLocation = LatLng(position.latitude, position.longitude);

          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                ),
                child: CreateClientBottomSheet(
                  location: currentLocation,
                  onClientCreated: (newClient) {
                    onClientSelected(newClient);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );

          await clientsCtrl.fetchAllClients();

        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$local.location_error: $e")),
          );
        }
      } else {
        onClientSelected(client);
      }
    },
  );
}
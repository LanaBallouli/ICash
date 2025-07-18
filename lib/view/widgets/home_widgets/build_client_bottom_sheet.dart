import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_sales/controller/address_controller.dart';
import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:provider/provider.dart';

import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class CreateClientBottomSheet extends StatefulWidget {
  final Function(Client) onClientCreated;
  final LatLng location;

  const CreateClientBottomSheet(
      {super.key, required this.onClientCreated, required this.location});

  @override
  State<CreateClientBottomSheet> createState() =>
      _CreateClientBottomSheetState();
}

class _CreateClientBottomSheetState extends State<CreateClientBottomSheet> {
  late TextEditingController nameCtrl;
  late TextEditingController notesCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    notesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveClient(BuildContext context) async {
    final local = AppLocalizations.of(context)!;
    final clientsCtrl = Provider.of<ClientsController>(context, listen: false);

    if (nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(local.fill_all_fields)),
      );
      return;
    }

    final addressCtrl = Provider.of<AddressController>(context, listen: false);
    try {
      final address = await addressCtrl.saveAddress(Address(
          latitude: widget.location.latitude,
          longitude: widget.location.longitude));
      final newClient = await clientsCtrl.addNewClient2(
        Client(
          tradeName: nameCtrl.text,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          addressId: address.id!,
        ),
      );

      widget.onClientCreated(newClient);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$local.error_saving_client: $e")),
      );
      print ("$e + error_saving_client");
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.add_new_client,
            style: AppStyles.getFontStyle(langCtrl,
                fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          InputWidget(
            textEditingController: nameCtrl,
            label: local.client_name,
            hintText: local.enter_client_trade_name,
          ),
          SizedBox(height: 16.h),
          InputWidget(
            textEditingController: notesCtrl,
            label: local.notes,
            hintText: local.add_notes,
            maxLines: 3,
          ),
          SizedBox(height: 20.h),
          CustomButtonWidget(
            title: local.save,
            color: AppConstants.primaryColor2,
            onPressed: () => _saveClient(context),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

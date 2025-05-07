import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_clinet_widgets/address_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/notes_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/type_input_widget.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';
import '../../widgets/management_widgets/add_salesman_widgets/phone_input_widget.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    final managementController =
        Provider.of<ManagementController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.add_client,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(),
              ),
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
                  nameController: managementController.clientNameController,
                  title: AppLocalizations.of(context)!.trade_name),
              PhoneInputWidget(
                phoneController: managementController.clientPhoneController,
                hintText: AppLocalizations.of(context)!.enter_client_phone,
              ),
              AddressInputWidget(),
              RegionInputWidget(
                selectedRegion: managementController.clientSelectedRegion,
              ),
              TypeInputWidget(
                hintText: AppLocalizations.of(context)!.choose_client_type,
                typeOptions: ["Cash", "Debt"],
                selectedType: managementController.clientSelectedType,
              ),
              SizedBox(
                height: 15.h,
              ),
              NotesInputWidget(
                notesController: managementController.clientNotesController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

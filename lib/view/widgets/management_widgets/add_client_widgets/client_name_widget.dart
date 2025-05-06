import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class ClientNameWidget extends StatelessWidget {
  String? hintText;

  ClientNameWidget({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Consumer<ManagementController>(
        builder: (context, managementController, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.trade_name,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                textEditingController: managementController.nameController,
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person),
                labelColor: Colors.grey,
                hintText: hintText ?? AppLocalizations.of(context)!.enter_name,
                onChanged: (value) => managementController.validateField(
                  field: 'name',
                  value: value,
                  context: context,
                ),
                errorText: managementController.errors['name'],
              ),
            ],
          );
        },
      ),
    );
  }
}
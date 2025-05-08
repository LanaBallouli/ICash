import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class AddressInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String title;

  const AddressInputWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final managementController = context.watch<ManagementController>();
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Selector<ManagementController, String?>(
        selector: (context, managementController) =>
            managementController.errors['address'],
        builder: (context, errorText, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                borderColor: Color(0xFFEFF0F6),
                textEditingController:
                    controller,
                obscureText: false,
                maxLines: 3,
                keyboardType: TextInputType.text,
                hintText: hintText,
                onChanged: (value) => managementController.validateField(
                  field: 'address',
                  value: value,
                  context: context,
                ),
                errorText: errorText,
              ),
            ],
          );
        },
      ),
    );
  }
}

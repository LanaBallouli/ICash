import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class PhoneInputWidget extends StatelessWidget {
  String? hintText;
  String? title;
  TextEditingController phoneController;
  dynamic Function(String)? onChanged;
  String? errorText;

  PhoneInputWidget({
    super.key,
    this.hintText,
    required this.phoneController,
    this.title,
    this.errorText,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<ManagementController>(
        builder: (context, managementController, _) {
          final error = managementController.errors['phone'];

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.phone,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                borderColor: Color(0xFFEFF0F6),
                textEditingController: phoneController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                hintText: hintText ?? AppLocalizations.of(context)!.phone_hint,
                onChanged: onChanged ??
                    (value) => managementController.validateField(
                          field: 'phone',
                          value: value,
                          context: context,
                        ),
                errorText: errorText ?? error,
              ),
            ],
          );
        },
      ),
    );
  }
}

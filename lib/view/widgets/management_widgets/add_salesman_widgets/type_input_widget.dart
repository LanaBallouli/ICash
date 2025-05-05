import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';

import '../../../../controller/lang_controller.dart';
import '../../../../controller/login_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';

class TypeInputWidget extends StatefulWidget {
  const TypeInputWidget({super.key});

  @override
  State<TypeInputWidget> createState() => _TypeInputWidgetState();
}

class _TypeInputWidgetState extends State<TypeInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> type = [
    "Cash",
    "Debt",
  ];

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    final managementController = context.watch<ManagementController>();

    // Ensure the initial value is valid
    final validValue = type.contains(managementController.typeController.text)
        ? managementController.typeController.text
        : null;

    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.type,
              style: AppStyles.getFontStyle(
                langController,
                color: Color(0xFF6C7278),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Selector<ManagementController, String?>(
              selector: (context, managementController) =>
              managementController.errors['type'],
              builder: (context, errorText, _) {
                return Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppConstants.buttonColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.0.sp, right: 14.sp),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        hint: Text(
                          AppLocalizations.of(context)!.choose_salesman_type,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFFBBBFC5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        value: validValue,
                        items: type
                            .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            managementController.typeController.text = value;
                            managementController.validateField(
                              field: 'type',
                              value: value,
                              context: context,
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || !type.contains(value)) {
                            return AppLocalizations.of(context)!.field_required;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';

class RegionInputWidget extends StatelessWidget {
  final String? selectedRegion;
  final String? hintText;
  final dynamic Function(String?)? onChanged;
  final String? Function(String?)? errorText;
  final String? err;

  RegionInputWidget(
      {super.key, this.selectedRegion, this.hintText, this.errorText, this.onChanged, this.err});

  final _formKey = GlobalKey<FormState>();

  final List<String> regions = [
    "Amman",
    "Zarqaa",
  ];

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    final managementController = context.watch<ManagementController>();

    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.region,
              style: AppStyles.getFontStyle(
                langController,
                color: Color(0xFF6C7278),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Selector<ManagementController, String?>(
              selector: (context, managementController) =>
                  managementController.errors['region'],
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
                        hint: Text(hintText ??
                          AppLocalizations.of(context)!.choose_region,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFFBBBFC5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        decoration: InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        value: selectedRegion ??
                            managementController.selectedRegion,
                        items: regions
                            .map((region) => DropdownMenuItem(
                                  value: region,
                                  child: Text(region),
                                ))
                            .toList(),
                        onChanged: onChanged ??
                            (value) {
                              managementController.setSelectedRegion(
                                  value, context);
                            },
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(err ?? "", style: TextStyle(color: Colors.red, fontSize: 12.sp),)
          ],
        ),
      ),
    );
  }
}

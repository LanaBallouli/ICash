import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';

class TypeInputWidget extends StatelessWidget {
  final String? selectedType;
  final String hintText;
  final List<String> typeOptions;
  final Function(String?)? onChange;
  final String? Function(String?)? errorText;

  TypeInputWidget({
    super.key,
    this.selectedType,
    required this.hintText,
    required this.typeOptions,
    this.onChange,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(top: 15.h),
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
          Consumer<ManagementController>(
            builder: (context, managementController, _) {
              final error = managementController.errors['type'];
              return Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppConstants.buttonColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.sp),
                    child: DropdownButtonFormField<String>(
                      hint: Text(
                        hintText,
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
                      value: managementController.selectedType ?? selectedType,
                      items: typeOptions
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: onChange ??(value) {
                        managementController.setSelectedType(value, context);
                      },
                      validator: errorText ?? (value) {
                        if (error != null) {
                          return error;
                        }
                        return null;
                      },
                      dropdownColor: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

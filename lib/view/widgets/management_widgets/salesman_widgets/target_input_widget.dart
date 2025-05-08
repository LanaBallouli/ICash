import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';

import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class TargetInputWidget extends StatelessWidget {
  const TargetInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final managementController = context.watch<ManagementController>();
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Selector<ManagementController, String?>(
        selector: (context, managementController) => managementController.errors['target'],
        builder: (context, errorText, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.select_target,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                borderColor: Color(0xFFEFF0F6),
                textEditingController: managementController.targetController,
                obscureText: false,
                keyboardType: TextInputType.number,
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                onChanged:
                    (value) => managementController.validateField(
                      field: 'target',
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

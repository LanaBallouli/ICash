import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';

import '../../../../controller/lang_controller.dart';
import '../../../../controller/login_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class PasswordFieldWidget extends StatelessWidget {
  String? hintText;

  PasswordFieldWidget({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    final managementController = context.watch<ManagementController>();
    final langController = Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.password,
            style: AppStyles.getFontStyle(
              langController,
              color: Color(0xFF6C7278),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Selector<ManagementController, bool>(
            selector: (context, managementController) =>
                managementController.obscureText,
            builder: (context, obscureText, _) {
              return InputWidget(
                textEditingController: managementController.passwordController,
                obscureText: obscureText,
                suffixIcon: IconButton(
                  onPressed: () =>
                      managementController.togglePasswordVisibility(),
                  icon: obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                labelColor: Colors.grey,
                hintText:
                    hintText ?? AppLocalizations.of(context)!.password_hint,
                onChanged: (value) => managementController.validateField(
                  field: 'password',
                  value: value,
                  context: context,
                ),
                errorText: managementController.errors['password'],
              );
            },
          )
        ],
      ),
    );
  }
}
